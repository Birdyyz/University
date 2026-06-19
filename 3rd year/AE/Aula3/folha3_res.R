library(dplyr)
library(ggplot2)
View(dados_eurostat)
names(dados_eurostat)
# Exercicio 2

temp <- dados_eurostat |>
  filter(country == "Portugal") |>
  select(year,Total)

ggplot(temp,aes(x = year, y = Total))+
  geom_line()

# Exercicio 3 

dif <- dados_eurostat |>
  filter(year == 2018) |>
  group_by(country) |>
  summarise(
    femeas = mean(Females,na.rm = TRUE),
    machos = mean(Males, na.rm = TRUE),
    media = femeas - machos
  ) |>
  arrange(desc(media)) |>
  head(5)
  
View(dif)

# Exercicio 4 

jvs <- dados_eurostat |> 
  filter(year >= 2014) |>
  group_by(country) |>
  summarise(
    media_jovens = mean(Under25, na.rm = TRUE),
    media_adultos = mean(Over25, na.rm = TRUE),
    r = media_jovens / media_adultos
  ) |>
  arrange(desc(r)) |>
  head(5)

View(jvs)

#Podemos concluir que a taxa de desemprego nos jovens é superior que nos adultos
# e nestes 5 paises essa diferença é maior

# Exercicio 6

maior_global <- dados_eurostat |>
  filter(year == 2018) |> 
  select(Males,Females,Total,country) |>
  group_by(country) |>
  summarise(
    media = mean(Total,na.rm = TRUE)
  ) |>
  arrange(desc(media)) |>
  head(5)

top5 <- maior_global$country

evolucao <- dados_eurostat |>
  filter(country %in% top5) |>
  select(country, year, Females, Males)

ggplot(evolucao, aes(x = year))+
  geom_line(aes(y = Females, color= "pink")) +
  geom_line(aes(y = Males, color="blue"))
