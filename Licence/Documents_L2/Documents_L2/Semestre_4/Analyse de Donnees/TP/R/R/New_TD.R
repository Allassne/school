#date : Mardi le 10 Mai 2022
library(readxl) #activer le package (dplyr, knitr)
str(tourism)
names(tourism)
summary(tourism)
m1 = filter(tourism, expenses < 300)
str(m1)
summary(m1)
m2 = filter(tourism, sex == 0)
table(tourism$country)
table(tourism$sex)
table(tourism$safety)
library(RcmdrMisc)
numSummary(tourism[ ,c("waitingtime","safety"), drop = FALSE],statistics = c("mean", "sd","IQR","quartiles"), quartiles = c(0,.25,.5,.75,1))
#mean = moyenne
#sd = ecart-type
#IQR = intervalle inter quartile
#Quartiles
f_sex <- as.factor(tourism$sex)
mode(f_sex)
tourism = cbind(tourism,f_sex)#ajouter la variable à la base de donnée
numSummary(tourism[ ,c("waitingtime","safety"), drop = FALSE],groups = tourism$f_sex, statistics = c("mean", "sd","IQR","quartiles"), quartiles = c(0,.25,.5,.75,1))
cor(tourism[ ,c("quality", "safety", "diversity", "waitingtime", "satisfaction")], method = "pearson", use = "complete")
plot(tourism $safety, tourism $quality)
plot(tourism $waitingtime, tourism $diversity)
pie(table(tourism $country), labels = c("suisse", "allemagne", "australie", "autre"), col = c("black", "darkblue", "grey", "orange"))
#vcd à télécharger
