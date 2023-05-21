
#Exercício de estruturação dos dados

library(data.table)
library(dplyr)
library(tidyverse)

general_data<-fread("http://dados.recife.pe.gov.br/dataset/eb9b8a72-6e51-4da2-bc2b-9d83e1f198b9/resource/5b2ffd31-2829-4347-adb5-5de43e53cb57/download/empresas_atividades.csv") # carrega dados das empresas de Recife por atividade 

NomeGrupo <- c("SAUDE", "EDUCACAO", "SERVICOS PUBLICOS, COMUNITARIOS E SOCIAIS")

AtividadesEmpresas <- general_data %>% filter(nome_grupo %in% NomeGrupo) # filtra casos apenas no vetor

AtividadesGrupo <- AtividadesEmpresas %>% group_by(nome_grupo) %>% mutate(row = row_number()) %>% select(nome_grupo, desc_atividade, row) # cria matriz de atividades, agrupando por grupo/tipo criando uma nova linha com index e selecionando apenas algumas variáveis

# filtra dados para garantir que todos os tipos de atividades tenham mesmo nro de casos
result <- AtividadesGrupo %>% group_by(nome_grupo) %>% filter(row == max(row))
AtividadesGrupo <- AtividadesGrupo %>% filter(row<=min(result$row)) 

# pivota o data frame de long para wide
AtividadesGrupo <-AtividadesGrupo %>% pivot_wider(names_from = row, values_from = desc_atividade) %>% remove_rownames %>% column_to_rownames(var="nome_grupo") 
