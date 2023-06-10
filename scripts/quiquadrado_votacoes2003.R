
## QUI-QUADRADO COM R ##
# PRIMEIRO, VAMOS CARREGAR OS PACOTES
pacman::p_load(data.table, ggplot2)
install.packages("readxl")
library(readxl)

# AGORA, A BASE DE DADOS VOTOS CAMARA DOS DEPUTADOS 2003#
votos = read_excel("votacoes2003.xlsx")

# TABELA DE CONTINGÊNCIA #
Tabela_Votações2003 <- table(votacoes2003$descricao, votacoes2003$orientacao)
Tabela_Votações2003

# GRÁFICOS DE DISPERSÃO PAREADOS DAS VARIÁVEIS #
ggplot(votacoes2003) + aes(x = orientacao, fill = descricao) + geom_bar(position = "fill")

# TESTE QUI QUADRADO #
votacao2003_test <- chisq.test(Tabela_Votações2003)
votacao2003_test
votacao2003_test$observed
votacao2003_test$expected

# CORRPLOT DAS VARIÁVEIS #
corrplot(votacao2003_testt$descricao, is.cor = FALSE)
