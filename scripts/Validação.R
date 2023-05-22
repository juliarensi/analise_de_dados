
#Validação

pacman::p_load(data.table, dplyr, tidyverse, validate)

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

north_america_countries <-c("Mexico", "Canada", "United States") # vetor que identifica países da América do Norte

north_america <- general_data %>% filter(location %in% north_america_countries) # filtra casos apenas no vetor

north_america <- north_america %>% select(location, new_cases, new_deaths)

regras_north_america <- validator(new_cases >= 0, new_deaths >= 0)

validacao_north_america <- confront(north_america, regras_north_america)

summary(validacao_north_america)

plot(validacao_north_america)