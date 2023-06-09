
## CORRELAÇÃO COM R ##
# PRIMEIRO, VAMOS CARREGAR OS PACOTES
pacman::p_load(corrplot, dplyr, ggplot2)

data(rock)
rock

# TABELA DE CORRELAÇÃO COM TODAS AS VARIÁVEIS #
cor(rock)

# GRÁFICOS DE DISPERSÃO PAREADOS DAS VARIÁVEIS #
pairs(rock)

# CORRPLOT DAS VARIÁVEIS #
RockCor <- cor(rock)
corrplot(RockCor, method = "number", order = 'alphabet')
corrplot(RockCor, order = 'alphabet')

