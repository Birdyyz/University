
library(titanic)
data(titanic_train)

View(titanic_train)
data("titanic_test")
View(titanic_test)

dim(titanic_train)
names(titanic_train)
str(titanic_train$Survived)
# passar para variavel qualitativa
titanic_train$Survived<-as.factor(titanic_train$Survived)
library(tidyverse)

dados_treino <- titanic_train |>
  select(Survived,Age,Pclass,Sex)
dados_treino

dados_treino <- drop_na(dados_treino)
dim(dados_treino)

summary(dados_treino$Survived)
modelo <- glm(Survived~Age+Pclass+Sex, data=dados_treino)

# ver se tem na
table(is.na(titanic_train))
is.na(titanic_train)
