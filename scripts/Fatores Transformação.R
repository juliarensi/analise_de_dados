

install.packages('ade4')
install.packages('arules')
library(ade4)
library(arules)
library(forcats)

# carrega base de análise
iris
str(iris)

#Transformando em fator colunas de 1 a 3
for(i in 1:3) {
  iris[,i] <- as.factor(iris[,i])
}

#Checando
str(iris)

#Filtragem dos dados que são fatores
factor_iris <- unlist(lapply(iris, is.factor)
iris_factor <- iris[ ,factor_iris]
str(iris_factor)

# One Hot Enconding: conversão de fatores em variáveis binárias
iris_binaria <- acm.disjonctif(iris_factor)

#visualização da base após One Hot Enconding
View(iris_binaria)

# discretizar: aplicar categorias para os dados que são integer
iris$Petal.Length <- discretize(iris$Petal.Length, method = 'interval', breaks = 3, labels = c('pequena', 'média', 'grande'))

# verificação da base que teve coluna com dados integer agora categorizada
View(iris)

# contagem dos fatores
fct_count(iris_factor$Sepal.Width)

# anonimização dos fatores
fct_anon(iris_factor$Sepal.Width)

# reclassificação dos fatores em mais comuns e outros
fct_lump(iris_factor$Sepal.Width, n = 1)