
#### CARREGANDO PACOTES ####
pacman::p_load(dplyr, tidyverse)

#### LENDO AS BASES PARA O R ####
# opção para quem baixou a base
empresas_atividades <- read.csv2('bases_originais/empresas_atividades.csv')

empresas_enderecos <- read.csv2('bases_originais/empresas_enderecos.csv')

# Uso de Join
empresas_atividades_endereco <- left_join(empresas_atividades, empresas_enderecos, by = c('cod_empresa' = 'cod_empresa'))