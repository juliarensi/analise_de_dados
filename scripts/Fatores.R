
#Armazenamento de fatores

Profissões <- c("professor", "medico", "advogado", "cozinheiro","cantor","pesquisador")
Profissões

#Variável Profissões como fator
as.factor(Profissões)

#Transformando fator em inteiro
fator <- as.factor(Profissões)
as.numeric(fator)
