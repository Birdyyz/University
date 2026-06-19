#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import torch
import torch.nn as nn
import math


# -------------------------
# Positional Encoding
# -------------------------
class PositionalEncoding(nn.Module):
    def __init__(self, d_model, max_len=100):
        super().__init__()

        pe = torch.zeros(max_len, d_model)  # table: rows=positions, cols=embedding dims

        for pos in range(max_len):
            for i in range(0, d_model, 2):  # step 2: fill sine at i, cosine at i+1
                pe[pos, i] = math.sin(pos / (10000 ** (i / d_model)))
                pe[pos, i + 1] = math.cos(pos / (10000 ** (i / d_model)))

        self.pe = pe.unsqueeze(0)  # add batch dim → (1, max_len, d_model)

    def forward(self, x):
        return x + self.pe[:, : x.size(1)]  # add positional signal to token embeddings


# -------------------------
# Attention
# -------------------------
class SelfAttention(nn.Module):
    def __init__(self, d_model):
        super().__init__()
        self.q = nn.Linear(d_model, d_model)  # query projection
        self.k = nn.Linear(d_model, d_model)  # key projection
        self.v = nn.Linear(d_model, d_model)  # value projection

    def forward(self, x):
        Q = self.q(x)  # (B, L, D) — what each token is looking for
        K = self.k(x)  # (B, L, D) — what each token offers
        V = self.v(x)  # (B, L, D) — what each token returns if selected

        scores = torch.matmul(Q, K.transpose(-2, -1)) / math.sqrt(
            Q.size(-1)
        )  # (B, L, L); divide by sqrt(d) to prevent softmax saturation
        weights = torch.softmax(
            scores, dim=-1
        )  # normalise across key positions → attention weights

        output = torch.matmul(weights, V)  # weighted sum of values → (B, L, D)

        return output


class MultiHeadAttention(nn.Module):
    def __init__(self, d_model, num_heads):
        super().__init__()
        self.heads = nn.ModuleList(
            [SelfAttention(d_model) for _ in range(num_heads)]
        )  # independent attention heads
        self.linear = nn.Linear(
            d_model * num_heads, d_model
        )  # project concatenated heads back to d_model

    def forward(self, x):

        head_outputs = [
            head(x) for head in self.heads
        ]  # each head attends independently
        concat = torch.cat(head_outputs, dim=-1)  # (B, L, D*num_heads)
        output = self.linear(concat)  # (B, L, D)

        return output


# -------------------------
# Transformer Block
# -------------------------


class FeedForward(nn.Module):
    def __init__(self, d_model, d_ff):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(d_model, d_ff),  # expand to wider hidden layer
            nn.ReLU(),
            nn.Linear(d_ff, d_model),  # project back to d_model
        )

    def forward(self, x):
        return self.net(
            x
        )  # applied independently to each position: (B, L, D) → (B, L, D)


class TransformerBlock(nn.Module):
    def __init__(self, d_model, num_heads, d_ff=256):
        super().__init__()

        self.attn = MultiHeadAttention(d_model, num_heads)
        self.norm1 = nn.LayerNorm(d_model)  # normalise after attention
        self.norm2 = nn.LayerNorm(d_model)  # normalise after feed-forward
        self.ff = FeedForward(d_model, d_ff)

    def forward(self, x):
        # Multi-head attention
        attn_output = self.attn(x)

        # Residual connection + layer norm (helps gradients flow through deep stacks)
        x = self.norm1(x + attn_output)

        # Feed-forward network
        ff_output = self.ff(x)

        # Residual connection + layer norm
        x = self.norm2(x + ff_output)
        return x


# -----------------------
# Full Transformer
# -----------------------
class Transformer(nn.Module):
    def __init__(self, vocab_size, d_model=64, num_heads=4, d_ff=256, num_layers=2):

        super().__init__()
        self.embedding = nn.Embedding(vocab_size, d_model)  # token id → dense vector
        self.pos = PositionalEncoding(d_model)  # add position signal
        self.layers = nn.ModuleList(
            [
                TransformerBlock(d_model, num_heads, d_ff) for _ in range(num_layers)
            ]  # stack of encoder blocks
        )
        self.fc = nn.Linear(
            d_model, vocab_size
        )  # project to vocabulary logits (for language modelling)

    def forward(self, x):  # x: (B, L) token ids
        x = self.embedding(x)  # (B, L, D)
        x = self.pos(x)  # (B, L, D) + positional encoding
        for layer in self.layers:
            x = layer(x)  # (B, L, D) through each TransformerBlock
        return self.fc(x)  # (B, L, vocab_size) — one logit vector per position


# -------------------------
# Example
# -------------------------

vocab_size = 100
seq_len = 10
batch = 2

model = Transformer(vocab_size)

x = torch.randint(0, vocab_size, (batch, seq_len))  # random token ids: (2, 10)

y = model(x)  # forward pass

print(y.shape)
