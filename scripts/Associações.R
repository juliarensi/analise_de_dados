
### CARREGAR PACOTES
pacman::p_load(ccaPP, lsa, minerva, Rfast)

### CRIAR FUNÇÃO PARA RODAR VÁRIAS ASSOCIAÇÕES
multi.cor <- function(x, y) {
  c(
    cor = cor(x, y), # Correlação
    dcor = dcor(x, y), # Distance correlation
    cosine = cosine(x, y), # Distância do Cosseno 
    maxCor = maxCorProj(x, y), # Maximal correlation
    MIC = mine (x, y) #  Maximal Information Coefficient
  )
}

iris

### EXEMPLO 1 LINEAR
x <- iris$Petal.Length
y <- iris$Petal.Width

plot(x, y) # Plotar o gráfico

corList <- multi.cor(x, y)
names(corList)
corList <- corList[c(1,5,6,7, 15)]
corList


### EXEMPLO 1.1 LINEAR 
y1 <- y - runif(150, 1.2, 6) # 150 = Número total de casos 
plot(x, y1)

corList1 <- multi.cor(x, y1)
corList1 <- corList1[c(1,5,6,7, 15)]
corList1

### EXEMPLO 2 QUADRÁTICA
k <- iris$Petal.Length
l <- iris$Petal.Width - 1.7*k + k^2

plot(k, l)

corList <- multi.cor(k, l)
corList <- corList[c(1,5,6,7, 15)]
corList

