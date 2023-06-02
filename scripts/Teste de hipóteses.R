
#Testes de hipóteses

# PACOTES #
pacman::p_load(data.table)

head(esoph)

tabela = table(esoph$agegp, esoph$alcgp)
tabela

#Teste qui quadrado
chisq.test(esoph$agegp, esoph$alcgp)

# H0: variáveis são independentes / não há associação. p-valor (p-value) > 0.05
# H1: variáveis são dependentes / há associação. p-valor (p-value) <= 0.05

#Dado que o p-value = 1, ou seja, p-value > 0.05, as variáveis são independentes.
#Não há associação entre faixa etária e consumo de álcool por dia