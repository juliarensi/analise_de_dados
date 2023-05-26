

### Estatística Descritiva com R

# carrega base
USArrests

## Tabela de frequência absoluta da variável Murder da base USArrests
table(USArrests$Murder)

## Tabela de frequência relativa da variável Murder da base USArrests
prop.table(table(USArrests$Murder))

## Média da variável Rape da base USArrests
mean(USArrests$Rape)

## Mediana da variável Rape da base USArrests
median(USArrests$Rape)

## Separatrizes da variável Rape da base USArrests
quantile(USArrests$Rape, probs=0.75)
quantile(USArrests$Rape, probs=0.10)
quantile(USArrests$Rape, probs=0.95)
boxplot(USArrests$Rape) # boxplot - gráfico que resume as sepatrizes

## Desvio-padrão da variável Rape da base USArrests
sd(USArrests$Rape)
plot(USArrests$Rape)

## Sumário descritivo básico das variáveis
summary(USArrests)

## Sumário descritivo completo das variáveis usando o pacote fBasics
pacman::p_load(fBasics)
basicStats(USArrests[ , c(1:4)])
hist(USArrests$Rape) # histograma - gráfico que permite conhecer a curva dos dados