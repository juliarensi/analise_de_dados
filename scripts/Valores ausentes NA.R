
#Valores ausentes

library(data.table)
library(funModeling)
library(tidyverse)

pacman::p_load(data.table, funModeling, tidyverse) 

Casos_Dengue <- fread('http://dados.recife.pe.gov.br/dataset/2a9b1c39-0700-4ddf-9a10-b3c8d5d9396c/resource/e4a91dfc-b479-4f63-8a83-018c21bc0312/download/dengon2021_recife.csv')

## identificando e removendo valores ausentes
status(Casos_Dengue) # estrutura dos dados (missing etc)

# Complete-case analysis – listwise deletion
dim(Casos_Dengue_Completo <- na.omit(Casos_Dengue)) 

# Variação de Complete-case analysis – listwise deletion
dim(Casos_Dengue_Completo <- Casos_Dengue %>% filter(!is.na(dt_nascimento)))

## estimando se o NA é MCAR, MAR ou MANR
## Shadow Matrix do livro R in Action

Casos_Dengue <- fread('http://dados.recife.pe.gov.br/dataset/2a9b1c39-0700-4ddf-9a10-b3c8d5d9396c/resource/e4a91dfc-b479-4f63-8a83-018c21bc0312/download/dengon2021_recife.csv')
head(Casos_Dengue) # observa a base

x <- as.data.frame(abs(is.na(Casos_Dengue))) # cria a matrix sombra
head(x) # observa a matriz sombra

y <- x[which(sapply(x, sd) > 0)] # mantém apenas variáveis que possuem NA

cor(y) # observa a correlação entre variáveis

cor(Casos_Dengue, y, use="pairwise.complete.obs") # busca padrões entre os valores específicos das variáveis e os NA

## Shadow Matrix da base de Casos de Dengue

Matrix_Casos_Dengue <- as.data.frame(abs(is.na(Casos_Dengue))) # cria a matriz sombra da base de Casos de Dengue

Matrix_Casos_Dengue <- Matrix_Casos_Dengue[which(sapply(Matrix_Casos_Dengue, sd) > 0)] # mantém variáveis com NA
round(cor(Matrix_Casos_Dengue), 3) # calcula correlações

# modificação já que vão temos uma base numérica
Matrix_Casos_Dengue <- cbind(Matrix_Casos_Dengue, raca = Casos_Dengue$tp_raca_cor) # trazemos uma variável de interesse (Raça) de volta pro frame
Casos_Dengue_Raca <- Matrix_Casos_Dengue %>% group_by(raca) %>% summarise(across(everything(), list(sum))) 