
### CARREGANDO PACOTES ###
pacman::p_load(car, gvlma, lm.beta, lmtest, MASS, sandwich)

USArrests

#Dispersão
plot(1:30)
plot(USArrests$Assault, USArrests$UrbanPop, main = 'Gráfico de Dispersão', xlab = 'Assaltos', ylab = 'População Urbana')

#Correlação
cor(USArrests$Assault, USArrests$UrbanPop)

#Regressão linerar simples
modelo <- lm(Assault ~ ., data = USArrests)
summary(modelo)
lm.beta(modelo) #Coeficientes padronizados
abline(modelo, col=2)

#Stepwise
modeloBoth <- step(lm(Assault ~ ., data = USArrests), direction = 'both')
summary(modeloBoth)

#Verificação dos pressupostos

#Normalidade dos resíduos
shapiro.test(residuals(modelo))
plot(modelo, which=1, col=c("blue")) # resíduos x ajuste
plot(modelo, which=2, col=c("red")) # Q-Q Plot
plot(modelo, which=5, col=c("blue"))  # Observações Influentes

# inflação da variância / multicolinearidade
vif(modelo)
barplot(vif(modelo), main = "VIF Values", horiz = FALSE, col = "steelblue", ylim = c(0,5))
abline(h = 5, lwd = 3, lty = 2)

# homocedasticidade (H0 = homocedasticidade)
bptest(modelo) # teste de homocedasticidade
plot(modelo, which=3, col=c("blue"))  # Scale-Location Plot
