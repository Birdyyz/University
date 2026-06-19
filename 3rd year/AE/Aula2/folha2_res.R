library(dplyr)
library(tidyr)
library(nycflights13)

# Exercicio 1 
summary(mtcars)

mtcars |>
  as_tibble(rownames = "modelo") |>
  filter(mpg > 25 , cyl %in% c(4,6)) |>
  mutate(kmpl = mpg * 0.4251,
         potencia = case_when(
           hp < 100 ~"baixa",
           hp < 150 ~"média",
           TRUE     ~ "alta"
         ))|>
  arrange(desc(kmpl)) |>
  select (modelo, mpg, cyl, hp) |>
  head(8)

# Exercicio 2 
nycflights13::flights |>
  group_by(carrier) |>
  summarise(
    n_voos = n(),
    dep_delay = mean(dep_delay, na.rm = TRUE),
    arr_delay = mean(arr_delay, na.rm = TRUE),
    across(c(dep_delay,arr_delay), list(media = mean, sd = sd))
  ) |>
  arrange(desc(n_voos)) |>
  head(10)

# Exercicio 3

vendas <- tibble(
  id = 1:4,
  Jan = c(10, 12, 9, 11),
  Fev = c(11, 8, 13, 10),
  Mar = c(9, 12, 7, 15)
)
long <- vendas |> 
  pivot_longer(cols = Jan:Mar, names_to = "mes", values_to = "valor")
long

long |> 
  pivot_wider(names_from = mes, values_from = valor)

nomes <- tibble(nome_completo = c("Ana Silva", "Bruno Costa","C. Rocha"))
nomes |>
  separate(nome_completo, into = c("primeiro","apelido"), sep = " ") |>
  unite("Nome_compacto", primeiro, apelido, sep = "_")

# Exercicio 4 

summary(airports)

voos_dest <- flights |>
  count(dest, name = "n_voos") |>
  left_join(
    airports |>
      select(faa, name),by = c("dest" = "faa")
  )
voos_inner <- flights |>
  inner_join(
    airports |>
      select(faa, name),by = c("dest" = "faa")
  )
summary(voos_dest)
summary(voos_inner)

voos_full <- flights |>
  full_join(
    airports|>
      select(faa,name),by = c("dest" = "faa")
  )

summary(voos_full)
