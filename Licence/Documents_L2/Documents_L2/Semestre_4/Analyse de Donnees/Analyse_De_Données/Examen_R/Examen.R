#1 Create the function pour calculer le mode de la variable hebergement
getmode <- function(accommodation) {
  uniqv <- unique(accommodation)
  uniqv[which.max(tabulate(match(accommodation, uniqv)))]
}

mode_hebergement <- getmode(tourism$accommodation)
View(mode_hebergement)

#1 Create the function pour calculer le mode de la variable education
getmode <- function(education) {
  uniqv <- unique(education)
  uniqv[which.max(tabulate(match(education, uniqv)))]
}
mode_education <- getmode(tourism$education)
View(mode_education)

#1 Create the function pour calculer le mode de la variable sejour
getmode <- function(stay) {
  uniqv <- unique(stay)
  uniqv[which.max(tabulate(match(stay, uniqv)))]
}
mode_sejour <- getmode(tourism$stay)
View(mode_sejour)

#2.Affichez la médiane et la moyenne pour les variables âge, dépenses et séjour. Interprétez les résultats.
#Mediane
View(median(tourism$age))
View(median(tourism$expenses))
View(median(tourism$stay))
#MOYENNE
numSummary(tourism[, c("age","expenses","stay"), drop = FALSE], statistics = "mean")

#3.	Calculez l'écart-type, la variance et les quantiles pour les variables suivantes âge, dépenses et séjour. Interprétez les résultats en même temps que ceux de la question 2.
#Ecart type et QUANTILES
numSummary(tourism[, c("age","expenses","stay"), drop = FALSE], statistics = c("sd","quantiles"), quantiles = c(0,.25,.5,.75,1))

#VARIANCE
var(tourism$age)
var(tourism$expenses)
var(tourism$stay)

#4.	Affichez la médiane, la moyenne, l'écart-type, la variance, l'intervalle interquartile, la plus petite valeur, la plus grande valeur, premier et le troisième quartile pour les variables suivantes : diversité, qualité, sécurité, satisfaction et temps d'attente avec une commande et comparez les résultats.
summary(tourism[, c("diversity","quality","safety","satisfaction","waitingtime"), drop = FALSE])

#5.	Calculez le coefficient de corrélation de Bravais-Pearson entre les deux variables suivantes l'âge et les dépenses. Interprétez le résultat.
cor(tourism[,c("age","expenses")],method = "pearson", use="complete")

#6.	Calculez les coefficients de corrélation de Bravais-Pearson entre les variables âge, dépenses et séjour en utilisant la matrice de corrélation. Interprétez les résultats.
cor(tourism[,c("age","expenses","stay")],method = "pearson", use="complete")

#7.	Créez un histogramme pour les dépenses variables et interprétez brièvement le graphique. Essayez d'étiqueter l'histogramme, l'axe des x et l'axe des y et donnez à l'histogramme la couleur violette.
hist(tourism$expenses, main="histogramme des dépenses",xlab="depense",ylab="frequence",col="violet")

#8.	Créez un diagramme circulaire pour la variable éducation et interprétez brièvement le diagramme circulaire. Essayez d'ajouter les noms aux pièces.
pie(table(tourism$education),main="Diagramme circulaire d'education",labels=c("secondary school","A-levels","bachelor","master"))

#9.	Essayez de créer un diagramme à barres qui affiche les invités par pays et par catégorie d'hébergement. Labéliser correctement le diagramme à barres et interprétez le résultat.
barplot(table(tourism$country,tourism$accommodation),main="diagramme à barres",xlab ="invites par pays d'hebergement",ylab="fequence",args.legend =c("pays","hebergement"),col ="darkblue")

#10. Créez une boîte à moustaches qui montre les dépenses par pays des invités. Labélisez-la et interprétez les résultats.
boxplot(tourism$expenses~tourism$country, main="variation des depenses par pays des invites",xlab="pays",ylab="depenses",names= c("switzerland","germany","australie","other"))

#11.	Dessinez un diagramme de dispersion pour les variables âge et dépenses. Labélisez-la et interprétez le résultat. Existe-t-il une relation linéaire (ligne droite) entre les deux variables ?
plot(tourism$age,tourism$expenses, main="redondance entre age et depense", xlab="age", ylab="depense",col="orange")