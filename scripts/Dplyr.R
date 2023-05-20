
#DPLYR: sumário, agrupamento, manipulação de casos e manipulação de colunas.

library(dplyr)

PessoasVacinadas <- read.csv2("http://dados.recife.pe.gov.br/dataset/7ccb3816-0d62-49e1-b39a-3159870883b0/resource/99b42b09-95af-47de-8411-ab99c380c3ef/download/vacinados.csv", sep=";")

# sumários
count(PessoasVacinadas, grupo) 

# # sumários com agrupamentos
PessoasVacinadas %>% group_by(grupo) %>% summarise(avg = mean(idade))

# manipulação de casos
PessoasVacinadas %>%  filter(grupo != "TRABALHADORES DA SAÚDE") %>% summarise(avg = mean(idade))
PessoasVacinadas %>%  filter(grupo != "TRABALHADORES DA SAÚDE") %>% group_by(grupo, sexo) %>% summarise(avg = mean(idade))

# ordenar casos
arrange(PessoasVacinadas, grupo) # ascendente
arrange(PessoasVacinadas, desc(grupo)) # descendente

# manipulação de colunas

# seleção de colunas
PessoasVacinadas %>% select(idade, grupo, sexo) %>% arrange(idade)

# renomear
PessoasVacinadas %>% rename(prioritario = categoria)