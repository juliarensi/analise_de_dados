

pacman::p_load(dplyr)

# carrega a base de snistros de transito do site da PCR

sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

# junta as bases de dados com comando rbind (juntas por linhas)
colunas_iguais <- names(sinistrosRecife2020Raw[
  intersect(
    names(sinistrosRecife2020Raw), names(sinistrosRecife2021Raw))])

sinistrosRecife2020Raw <- sinistrosRecife2020Raw %>% select(all_of(colunas_iguais))

colunas_iguais_2019<- names(sinistrosRecife2019Raw[
  intersect(
    names(colunas_iguais), names(sinistrosRecife2019Raw))])

sinistrosRecife2019Raw <- sinistrosRecife2019Raw %>% select(all_of(colunas_iguais_2019))

sinistrosRecifeRaw <- rbind(sinistrosRecife2019Raw, sinistrosRecife2020Raw, sinistrosRecife2021Raw)

# observa a estrutura dos dados
str(sinistrosRecifeRaw)

# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)

# modificação do bairro de texto para fator
sinistrosRecifeRaw$bairro_cruzamento <- as.factor(sinistrosRecifeRaw$bairro)

# cria função para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

#Exportando no formato do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

#### Staging area e uso de memória

# ficamos com staging area??

ls() # lista todos os objetos no R

# vamos ver quanto cada objeto está ocupando

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}

ls() # lista todos os objetos no R

# Objetos que mais estavam ocupando espaço no R:

[1]         sinistrosRecife2020Raw                        1655440
[1]         sinistrosRecife2021Raw                        1057920
[1]         sinistrosRecife2022Raw                        5851088
[1]             sinistrosRecifeRaw                        2479456

# agora, vamos remover os itens que não são de interesse

rm(list=(ls()[ls()!="sinistrosRecifeRaw"]))

#listagem final para verificar se ficaram os itens de interesse
ls()

saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")
