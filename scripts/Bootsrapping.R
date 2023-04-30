
#Função rnorm para criar uma distribuição normal
distNormal <- rnorm(250) 
distNormal

# Criando bootstrapping
bootsDistNormal20 <- replicate(20, sample(distNormal, 10, replace = TRUE)) # replicando 20x a amostra - bootstrapping
bootsDistNormal20

# calculando uma estatística com bootstrapping (14 casos)
meanBootsNormal20 <- replicate(20, mean(sample(distNormal, 14, replace = TRUE))) # calculamos a média de 20 amostras de 14 casos
meanBootsNormal40 <- replicate(40, mean(sample(distNormal, 14, replace = TRUE))) # calculamos a média de 40 amostras de 14 casos
meanBootsNormal80 <- replicate(80, mean(sample(distNormal, 14, replace = TRUE))) # calculamos a média de 80 amostras de 14 casos

# Comparando as médias
mean(meanBootsNormal20) # media do boostraping 10
mean(meanBootsNormal40) # media do boostraping 50
mean(meanBootsNormal80) # media do boostraping 100
mean(distNormal) # media dos dados originais


