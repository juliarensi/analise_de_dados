install.packages("eeptools")
library(eeptools)

#Exercício Data Frame

#Vetor com nome dos alunos
nomeAluno <- c("Julia", "Alan", "Rennan", "Renata")

#Vetor com titulação que os alunos almejam alcançar
titulacaoAluno <- c("Doutorado", "Mestrado", "Mestrado", "Doutorado")

#Vetor com metodo de pesquisa dos alunos
metodoPesquisa <- c("Misto","Quanti","Quali","Misto")

#Data frame com base nos vetores criados
pesquisaAluno <- data.frame(nome = nomeAluno, titulação = titulacaoAluno, método = metodoPesquisa)

View(pesquisaAluno)
str(pesquisaAluno)
