
#Identificando Outliers

pacman::p_load(data.table, dplyr, plotly)
install.packages('EnvStats')

# carregar dados covid19 Pernambuco
covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')

covid19PEMun <- covid19PE %>% count(municipio, sort = T, name = 'casos') %>% mutate(casos2 = sqrt(casos), casosLog = log10(casos))

## outliers em variáveis
# distância interquartil

plot_ly(y = covid19PEMun$casosLog, type = "box", text = covid19PEMun$municipio, boxpoints = "all", jitter = 0.3)
boxplot.stats(covid19PEMun$casosLog)$out
boxplot.stats(covid19PEMun$casosLog, coef = 2)$out

covid19PEOut <- boxplot.stats(covid19PEMun$casosLog)$out
covid19PEOutIndex <- which(covid19PEMun$casosLog %in% c(covid19PEOut))
covid19PEOutIndex

# filtro de Hamper
lower_bound <- median(covid19PEMun$casosLog) - 3 * mad(covid19PEMun$casosLog, constant = 1)
upper_bound <- median(covid19PEMun$casosLog) + 3 * mad(covid19PEMun$casosLog, constant = 1)
(outlier_ind <- which(covid19PEMun$casosLog < lower_bound | covid19PEMun$casosLog > upper_bound))

# teste de Rosner
library(EnvStats)
covid19PERosner <- rosnerTest(covid19PEMun$casosLog, k = 10)
covid19PERosner
covid19PERosner$all.stats