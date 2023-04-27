
#Atividade "Calculando"

rbinom(550, 50, 0.1) #Criação de uma distribuição binomial

# Criação de um objeto contendo uma distribuição binomial
amostraAleatoria <- rbinom(550, 50, 0.1)
hist(amostraAleatoria) #Histograma da distribuição binomial

#Centralização dos dados
amostraAleatoriaCentral <- amostraAleatoria - mean(amostraAleatoria)
hist(amostraAleatoriaCentral) #Histograma da centralização dos dados

# Nota: distorção dos dados. Não existem eventos negativos.
