library(tidyverse)

set.seed(1234)
n <- 200

alunos <- tibble(
  id            = 1:n,
  curso         = sample(c("CC", "SI"), n, replace = TRUE, prob = c(.65, .35)),
  ano           = sample(1:3, n, replace = TRUE, prob = c(.4, .35, .25)),
  sexo          = sample(c("F", "M"), n, replace = TRUE),
  horas_estudo  = round(rlnorm(n, meanlog = log(6), sdlog = 0.5), 1),
  faltas        = pmax(0, round(rpois(n, lambda = 3) - rbinom(n, 1, .1)*3)),
  nota          = pmin(20,
                       pmax(0,
                            round( 8 +
                                     0.6 * pmin(horas_estudo, 20) -
                                     0.4 * pmin(faltas, 10) +
                                     rnorm(n, 0, 2.5), 1)))
) %>%
  mutate(
    # introduzir alguns outliers na nota
    nota = replace(nota, sample(1:n, 3), c(2, 19.5, 0)),
    # introduzir NAs em horas_estudo
    horas_estudo = replace(horas_estudo, sample(1:n, 6), NA_real_)
  )

head(alunos) #visualizar primeiras 6 linhas

# Exercicio 1

dim(alunos)

glimpse(alunos)

# id -> qualitativa nominal
# curso -> qualitativa nominal
# ano -> quantitativa discreta
# sexo -> qualitativa nominais 
# horas_estudo -> quantitativa continua 
# faltas -> quantitativa discreta 
# nota -> quantitativa continua (pode ter decimais)

# Exercicio 2
with(alunos, c(mean = mean(nota, na.rm = TRUE),
               median = median(nota,ra.rm = TRUE),
               sd = sd(nota,na.rm = TRUE),
               IQR = IQR(nota),
               MAD = mad(nota, constant = 1, na.rm = TRUE)))

summary(alunos$nota)

# a media e um pouco maior q a mediana, 10.97 > 10.6 -> assimetria positiva 
# tem algumas notas altas mas a maioria sao abaixo delas 

# Exercicio 3 

q1 <- quantile(alunos$nota, .25, na.rm=TRUE)
q3 <- quantile(alunos$nota, .75, na.rm=TRUE)

iqr <- q3 - q1
low <- q1 - 1.5*iqr; high <- q3 + 1.5*iqr

which_out <- which(alunos$nota < low | alunos$nota > high)

ggplot(alunos,aes(y = nota))+
  geom_boxplot(outlier.color = "black")

# Exercicio 4 

ggplot(alunos,aes(x = nota))+
  geom_histogram(binwidth= 1, fill = "black", color = "white")+
  geom_density(fill = "black", alpha = 0.5)

# Exercicio 5 

ggplot(alunos,aes(x = curso, y = nota))+
  geom_boxplot(fill = "black")

# temos algumas notas em cc que nao estao no centro, duas muito abaixo e uma muito acima,
# fora essas de cc as notas estao bem centralizadas 
# ja em SI nao temos nenhuma fora do centro 

alunos %>%
   group_by(curso, sexo) %>%
   summarise(n = n(),
            media = mean(nota, na.rm=TRUE),
           mediana = median(nota, na.rm=TRUE),
           IQR = IQR(nota, na.rm=TRUE),
           .groups = "drop")

# em cc temos 3 outliers, dois abaixo e um acima

# Exercicio 6 

semna <- alunos %>% drop_na(horas_estudo,nota)
ggplot(semna, aes(x = horas_estudo, y = nota))+
         geom_point()+
         geom_smooth(method = "lm", se = FALSE, color = "black")
       
cor_pearson  <- cor(semna$horas_estudo, semna$nota, method="pearson")
cor_spearman <- cor(semna$horas_estudo, semna$nota, method="spearman")
c(pearson = cor_pearson, spearman = cor_spearman)

# Exercicio 7

ggplot(semna, aes(x = horas_estudo))+
  geom_histogram(binwidth = 0.5, fill = "black", color = "gray")

ggplot(semna, aes(x = horas_estudo))+
  geom_density(fill = "black", alpha = 0.5)

log_horas = log(semna$horas_estudo)

ggplot(semna,aes(x = log_horas))+
  geom_histogram(fill = "black", alpha = 0.5)
ggplot(semna, aes(x = log_horas))+
  geom_density(fill = "black", alpha = 0.5)

# Exercicio 8 

nas = is.na(alunos)

lista_completa <- drop_na(alunos) 

summary(lista_completa)

imp_simples <- alunos |>
  mutate(horas_estudo = if_else(is.na(horas_estudo),
                                median(horas_estudo,na.rm=TRUE),
                                horas_estudo))
lista_completa |>
  group_by(curso) |>
  summarise(media_nota = mean(nota, na.rm=TRUE))
imp_simples |>
  group_by(curso) |>
  summarise(media_nota = mean(nota,na.rm=TRUE))