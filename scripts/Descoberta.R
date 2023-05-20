
install.packages('funModeling')
library(funModeling)

install.packages('tidyverse')
library(tidyverse)

# olhada nos dados
glimpse(mtcars)

# verificar estrutura dos dados (quantos zeros, infinitos, casos únicos, etc)
status(mtcars)

# variáveis que são fatores e suas frequências
freq(mtcars)

# histograma das variáveis numéricas
plot_num(mtcars)

# estatísticas das variáveis numéricas
profiling_num(mtcars)