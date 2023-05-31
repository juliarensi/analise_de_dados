
#Análise Exploratória com Gráficos: histograma, boxplot e dispersão

## Carregar pacotes que serão usados
pacman::p_load(dplyr, ggplot2)

#Histograma: plota uma variável contínua no eixo x e a frequência de cada categoria no eixo y

data("CO2")
CO2

ggplot(CO2, aes(x = uptake)) +
  geom_histogram()

# Histograma com 30 classes:
ggplot(CO2, aes(x = uptake)) +
  geom_histogram(bins = 30) +
  ggtitle("30 classes")

# Histograma com cores para diferentes categorias com sobreposição
ggplot(CO2, aes(x = uptake, fill = Type)) +
  geom_histogram() +
  ggtitle("Com sobreposiçao")

#Boxplot: plota uma variável contínua no eixo y em função de uma variável categórica no eixo x 

ggplot(CO2, aes(y = uptake, x = Type)) +
  geom_boxplot()

# Destacando os outliers
ggplot(CO2, aes(y = uptake, x = Type)) +
  geom_boxplot(outlier.color = "purple")

# Bloxplot com cores para diferentes categorias com sobreposição
ggplot(CO2, aes(y = uptake, x = Type, fill = Type)) +
  geom_boxplot() 

#Gráfico de dispersão: representa a relação entre duas (ou mais) variáveis de um banco de dados

ChickWeight
ggplot(ChickWeight, aes(y = weight, x = Time)) +
  geom_point()

#Gráfico de dispersão com shape 21
ggplot(ChickWeight, aes(y = weight, x = Time)) +
  geom_point(shape = 21, size = 3)




