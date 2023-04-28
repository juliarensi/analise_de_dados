
# Criando variáveis normal, binomial e index

distNormal <- rnorm(220) #função rnorm para criar uma distribuição normal
summary(distNormal)

dbinom(7, 10, 0.35)
distBinomial <- dbinom(7, 10, 0.35) #cálculo da densidade dbinom

indexNormal <- seq(1, length(distNormal)) # vetor com índex dos dados
indexNormal


