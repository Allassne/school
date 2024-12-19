# Seance Analyse de donnée 
# Nom et Prénom : Paul yves
# date : Lundi le 09 mai 2022

Id = c(1:15)
Age = c(17,19,17,19,18,21,35,21,23,18,17,20,21,19,22)
poids = c(55,70,50,45,51,62,61,53,45,78,100,70,53,61,55)
Sexe = c("F","F","M","F","M","M","M","F","M","M","F","M","F","F","F")
Taille = c("small","medium","small","small","medium","high","small","high","small","medium","high","small","small","high","medium")
# creation d'une base de donnée (DB)
base = data.frame(Id,Age,poids,Sexe,Taille)
View(base)
#voir la structure de la base 
str(base) #les observation
head(base)#les prémiers obs
tail(base)#les dernieres obs
levels(base $Taille) #niveaux
# voir la statistique
summary(base)
table(base $Taille)
table(base $Taille, base $Sexe) #tableau croisé
var(base $Age)#variance
sd(base $Age)# ecart-type
cor(base $Age, base $poids)#correlation
cov(base $Age, base $poids)#covariance

#Elements graphique
boxplot(Age) #boite a moustaches
barplot(table(base $Sexe), main = "Diagramme à barres", xlab = "Sexe", ylab = "fréquence", args.legend = c("M","F"), col = "red") #diagramme en bande
hist(base $Age, main = "Histogramme de l'age", xlab = "age", ylab = "fréquence", col = "orange")#histogramme
pie(table(base $Taille)) #Diagramme circulaire
#example(pie)
barplot(table(base $Sexe, base $Taille), main = "Taille de vetements", xlab = "Taille tee-shrit", ylab = "Fréquence", names.arg = c("high","medium","small"), beside = TRUE, col = c("darkblue","red"), legend = row.names(table(base $Sexe, base $Taille)))
