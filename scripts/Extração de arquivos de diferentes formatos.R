
#Extração de arquivos de diferentes formatos

# arquivos de excel
install.packages('readxl')
library(readxl)

AcidentesRecife2022 <- read_excel("bases_originais/acidentes-2022.xlsx", sheet=1)

# arquivos json
install.packages('rjson')
library(rjson)

areas_de_risco <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/159bf7d4-4424-4d37-b830-d19ae76cd500/download/sedecchamados.json" )

areas_de_risco <- as.data.frame(areas_de_risco)


# arquivos de texto com read.csv2
unidade_saude_da_familia <- read.csv2('http://dados.recife.pe.gov.br/dataset/abc2d796-aa13-4ea0-b83a-13605ff98b87/resource/7ec4de7c-004c-4be1-88b1-80b70cf1250a/download/usf.csv', sep = ';', encoding = 'UTF-8')





