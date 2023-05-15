
#Extração e leitura

#Instalando pacote
install.packages('microbenchmark')
library(microbenchmark)

#Exportando no formato do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

# exportando em formato tabular (.xls) com outro comando
write.table(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.xls")

# carrega base de dados em formato nativo R 
sinistrosRecife <- readRDS("bases_tratadas/sinistrosRecife.rds")

#carrega base de dados em formato tabular (.csv)
sinistrosRecife <- read.csv2("bases_tratadas/sinistrosRecife.csv", sep = ';')

# carrega base de dados em formato tabular (.xls) 
sinistrosRecife <- read.table("bases_tratadas/sinistrosRecife.xls", sep = ';')

# compara os três processos de exportação, usando a função microbenchmark

microbenchmark(a <- saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds"), b <- write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv"), c <- write.table(sinistrosRecife, "bases_tratadas/sinistrosRecife.xls"), times = 30L) # .rds responde mais rápido

microbenchmark(a <- readRDS('bases_tratadas/sinistrosRecife.rds'), b <- read.csv2('bases_tratadas/sinistrosRecife.csv', sep = ';'), c <- read.table('bases_tratadas/sinistrosRecife.xls', sep = ';'), times = 30L)









