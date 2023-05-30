


# imputação de valores em outliers ou missing
pacman::p_load(data.table, Hmisc, VIM) # carrega pacotes

## imputação numérica
# preparação da base, colocando NA aleatórios
mtcars
(mtcarsNASeed <- round(runif(10, 1, 30))) # criamos 10 valores aleatórios
(mtcars$hp[mtcarsNASeed] <- NA) # imputamos NA nos valores aleatórios

# tendência central
mtcars$hp <- impute(mtcars$hp, fun = mean) # média
mtcars$hp <- impute(mtcars$hp, fun = median) # mediana

is.imputed(mtcars$hp) # teste se o valor foi imputado
table(is.imputed(mtcars$hp)) # tabela de imputação por sim / não

# predição
mtcars$hp[mtcarsNASeed] <- NA # recolocamos os NA

regmtcars <- lm(hp ~ ., data = mtcars) # criamos a regressão
mtcarsNAIndex <- is.na(mtcars$hp) # localizamos os NA
mtcars$hp[mtcarsNAIndex] <- predict(regmtcars, newdata = mtcars[mtcarsNAIndex, ]) # imputamos os valores preditos

## Hot deck
# imputação aleatória
mtcars$hp[mtcarsNASeed] <- NA # recolocamos os NA

(mtcars$hp <- impute(mtcars$hp, "random")) # fazemos a imputação aleatória

# imputação por instâncias /semelhança
mtcars$hp[mtcarsNASeed] <- NA # recolocamos os NA
mtcars2 <- kNN(mtcars)