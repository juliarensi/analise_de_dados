
#Instalando e chamando os pacotes
pacman::p_load(ade4, car, caret, corrplot, dplyr, EnvStats, gvlma, jtools, lm.beta, lmtest, MASS, Metrics, performance, sandwich, simpleboot, SmartEDA, sjPlot, stargazer, see, ggrepel, qqplotr)
pacman::p_load(sandwich, lmtest)
install.packages('devtools')
library(devtools)
install.packages("patchwork")
library(patchwork)
devtools::install_github("vdeminstitute/vdemdata")
devtools::install_github("andybega/states")

vdem.raw <- data.table::setDT(vdemdata::vdem)
vdem.codebook <- data.table::setDT(vdemdata::codebook)

#Selecionando as variáveis

metricas <- c("v2x_execorr", "v2exrescon", "v2jucomp", "v2juhccomp", "v2juhcind", "v2juncind")
id.vars <- c("country_name", "COWcode", "histname", "codingstart_contemp", "codingend_contemp", "year")
vars <- c(id.vars, metricas)
vdem.raw <- vdem.raw[, ..vars]
vdem <- vdem.raw

#Selecionando o ano
vdem <- vdem[year>2019]
ExpData(data=vdem, type=2)

# Mudando o nome das variáveis
colnames(vdem)[07:12] <- c('Corrupcao_Executivo', 'Respeito_Constituicao', 'Compliance_Judiciario', 'Compliance_Tribunal_Superior', 'Independencia_Tribunal_Superior', 'Independencia_Instancias_Inferiores')

# Criando as regressões stepwise
regBack <- step(lm(Corrupcao_Executivo ~ Respeito_Constituicao + Compliance_Judiciario + Compliance_Tribunal_Superior + Independencia_Tribunal_Superior + Independencia_Instancias_Inferiores, data = vdem), direction = "backward")
regForw <- step(lm(Corrupcao_Executivo ~ Respeito_Constituicao + Compliance_Judiciario + Compliance_Tribunal_Superior + Independencia_Tribunal_Superior + Independencia_Instancias_Inferiores, data = vdem), direction = "forward")
regBoth <- step(lm(Corrupcao_Executivo ~ Respeito_Constituicao + Compliance_Judiciario + Compliance_Tribunal_Superior + Independencia_Tribunal_Superior + Independencia_Instancias_Inferiores, data = vdem), direction = "both")

#Comparando os modelos
# Sumários
stargazer(regBack, regForw, regBoth, type="text", object.names = TRUE, title="Modelos Vdem", single.row=TRUE)
plot_summs(regBack, regForw, regBoth, model.names = c("Backward", "Forward", "Both"))

# Performance
test_performance(regBack, regForw, regBoth)
compare_performance(regBack, regForw, regBoth, rank = TRUE, verbose = FALSE)
plot(compare_performance(regBack, regForw, regBoth, rank = TRUE, verbose = FALSE))

### Diagnóstico ###
# checagem geral #
check_model(regBoth)

# testes unitários #
shapiro.test(residuals(regBoth)) #Checando normalidade dos resíduos
plot(regBoth, wich = 1)
plot(regBoth, wich = 2)
check_heteroscedasticity(regBoth) #Checando heteroscedasticidade
bptest(regBoth)
plot(regBoth, wich = 3)
check_collinearity(regBoth) #Checando colinearidade
vif(regBoth)
check_outliers(regBoth) #Checando outliers e valores influentes
influencePlot(regBoth, id.method="identify", main="Observações Influentes", sub="Círculo proporcional à distância de Cook")
residualPlots(regBoth)
summary(regBoth)

#Ajustes do modelo#
# para ajustar a linearidade
vdem$respeito_constituicao_r <- sqrt(vdem$Respeito_Constituicao)
vdem$compliance_judiciario_r <- sqrt(vdem$Compliance_Judiciario)
vdem$Independencia_Tribunal_Superior_r <- sqrt(vdem$Independencia_Tribunal_Superior)

# tirando as variaveis da base original
vdem <- vdem %>% dplyr::select(-c(Compliance_Judiciario, Respeito_Constituicao, Independencia_Tribunal_Superior)) 
vdem <- vdem[complete.cases(vdem), ]

# Novo ajuste de regressão
regvdemBoth2 <- step(lm(Corrupcao_Executivo ~ respeito_constituicao_r + compliance_judiciario_r + Compliance_Tribunal_Superior + Independencia_Tribunal_Superior_r + Independencia_Instancias_Inferiores, data = vdem, direction = "both"))

summary(regvdemBoth2)

# Ver quais problemas tem agora
par(ask = FALSE)
check_model(regvdemBoth2)
residualPlots(regvdemBoth2)

# Corrigir os residuos
cooksvdem <- cooks.distance (regvdemBoth2)
obsinfluente <- cooksvdem[cooksvdem > 4*mean(cooks, na.rm=T)]
vdem %>% slice(c(as.integer(names(obsinfluente))))

vdem2 <- vdem %>% slice(-c(as.integer(names(obsinfluente)))) # tirando todas os outliers
regvdemboth4 <- step((lm(Corrupcao_Executivo ~ Compliance_Tribunal_Superior + Independencia_Tribunal_Superior_r + respeito_constituicao_r, data = vdem2, direction = "both")))
summary(regvdemboth4)

check_model(regvdemboth4)

regvdemboot <- Boot(regvdemBoth2, R=500)

summary(regvdemboot, high.moments = TRUE) # correção de outliers por boot

check_heteroscedasticity(regvdemboth4)

bptest(regvdemboth4)

# Ajeitando a heterocedasticidade
regvdemhet <- coeftest(regvdemboth4, vcov. = vcovHC, type = "HC1")
summary(regvdemhet)
check_heteroscedasticity("regvdemhet")
regvdemhet
bptest(regvdemhet)
check_model(regvdemhet)



