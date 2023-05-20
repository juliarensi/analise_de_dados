
library(dplyr)

# carrega base de dados original
SedecVistorias <- read.csv2('http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/bb4b8cdb-122b-491a-80f7-b028b66108e1/download/sedec_vistorias.csv', sep = ';', encoding = 'UTF-8')

SedecVistorias <- SedecVistorias[-3,]

# carrega base de dados para atualização
SedecVistoriasNova <- read.csv2('http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/bb4b8cdb-122b-491a-80f7-b028b66108e1/download/sedec_vistorias.csv', sep = ';', encoding = 'UTF-8')

# compara usando a chave primária
SedecVistoriasIncremento <- (!SedecVistoriasNova$processo_numero %in% SedecVistorias$processo_numero)

# retorna vetor com incremento
SedecVistorias[SedecVistoriasIncremento,]

# junta base original e incremento
SedecVistorias <- rbind(SedecVistorias, SedecVistorias[SedecVistoriasIncremento,])