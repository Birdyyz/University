req <- c("tidyverse","broom","palmerpenguins","nycflights13","car","performance","GGally", "see")
new <- setdiff(req, rownames(installed.packages()))
if(length(new)) install.packages(new)

library(tidyverse)
library(broom)
library(palmerpenguins)
library(nycflights13)
library(car)           # VIF e diagnóstico
library(performance)   # checks de suposições
library(GGally)        # ggpairs
library(see)          # diagnóstico

penguins <- palmerpenguins::penguins |> drop_na()
glimpse(penguins)
summary(penguins)


flts <- nycflights13::flights |>
  filter(!is.na(dep_delay), !is.na(arr_delay),
         !is.na(distance), !is.na(air_time)) |>
  # amostra reprodutível
  slice_sample(n = 30000, replace = FALSE)
glimpse(flts)

## Exercicio 1

# Exercicio 1.1
# a
penguins1 <- penguins |> 
  select(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g)

ggpairs(penguins1)

#b
cor(penguins1)
cor(penguins1, method= "pearson")

#Exercicio 1.2
# a
flights <- flts |>
  select(arr_delay,dep_delay,distance,air_time)
# b
cor(flights)

# c) entre o comprimento da barbatana e o tamanho do bico 
# o q mais esta relacionado com a body_mass_g é o tamanho da barbatana

## Exercicio 2


#Exercicio 2.1
modelo <- lm(body_mass_g ~ bill_length_mm + bill_depth_mm * flipper_length_mm + species + sex, data = penguins)
summary(modelo)

# variaveis mais associadas ao peso dos pinguins: especie, sexo, comprimento do bico
# os pinguins q pesam mais -> machos, em media +389.5
# especie Chinstrap pesa menos q a categoria de referencia (-249.78)
# especie Gentoo pesa mais q a categoria de referencia (983.51)
# comprimento do bico o seu coeficiente é 18.3 -> quanto maior o comprimento do bico maior será o peso do pinguim
# quando o comprimento do bico aumenta uma unidade, o peso do pinguim aumenta em media 18.28 
# a iteração não é significativa
# a qualidade de ajustamento do modelo -> R-squared, 87.5% é boa
# convem tbm fazermos analise dos residuos para saber se os pressupostos sao validos ou nao

# exercicio 2.3

vif(modelo)
# temos valores de VIF > 5, esta refletido o de cima, temos q eliminar uma delas, comparamos com a matriz de correlacoes
#e vemos qual q esta mais relacionada com o peso 
# neste caso nenhuma delas é significativa, podemos  tirar as duas

# Exercicio 3 

# exercicio 3.1 

par(mfrow=c(1,3))
plot(modelo, which = 1)
plot(modelo, which = 2)
plot(modelo, which = 5)

par(mfrow=c(1,1))

# os erros devem ser independentes (nao devemoster grupos nos residuos)
# neste caso parece haver grupos logo nao sao independentes
# a media dos residuos parece aproximandamente 0
# parece ser constante

# no segundo grafico
# tem haver com a distribuicao dos residuos, parece normal , conseguimos calcular os intervalos com mais confianca
# terceiro
# se temos observacoes muito influentes, temos 293 e 0 325, tem comportamentos diferentes comparado aos restantes






















