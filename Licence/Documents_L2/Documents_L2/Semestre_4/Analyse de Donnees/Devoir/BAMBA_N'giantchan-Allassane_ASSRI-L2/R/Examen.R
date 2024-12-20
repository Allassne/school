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

#2.Affichez la m�diane et la moyenne pour les variables �ge, d�penses et s�jour. Interpr�tez les r�sultats.
#Mediane
View(median(tourism$age))
View(median(tourism$expenses))
View(median(tourism$stay))
#MOYENNE
numSummary(tourism[, c("age","expenses","stay"), drop = FALSE], statistics = "mean")

#3.	Calculez l'�cart-type, la variance et les quantiles pour les variables suivantes �ge, d�penses et s�jour. Interpr�tez les r�sultats en m�me temps que ceux de la question 2.
#Ecart type et QUANTILES
numSummary(tourism[, c("age","expenses","stay"), drop = FALSE], statistics = c("sd","quantiles"), quantiles = c(0,.25,.5,.75,1))

#VARIANCE
var(tourism$age)
var(tourism$expenses)
var(tourism$stay)

#4.	Affichez la m�diane, la moyenne, l'�cart-type, la variance, l'intervalle interquartile, la plus petite valeur, la plus grande valeur, premier et le troisi�me quartile pour les variables suivantes : diversit�, qualit�, s�curit�, satisfaction et temps d'attente avec une commande et comparez les r�sultats.
summary(tourism[, c("diversity","quality","safety","satisfaction","waitingtime"), drop = FALSE])

#5.	Calculez le coefficient de corr�lation de Bravais-Pearson entre les deux variables suivantes l'�ge et les d�penses. Interpr�tez le r�sultat.
cor(tourism[,c("age","expenses")],method = "pearson", use="complete")

#6.	Calculez les coefficients de corr�lation de Bravais-Pearson entre les variables �ge, d�penses et s�jour en utilisant la matrice de corr�lation. Interpr�tez les r�sultats.
cor(tourism[,c("age","expenses","stay")],method = "pearson", use="complete")

#7.	Cr�ez un histogramme pour les d�penses variables et interpr�tez bri�vement le graphique. Essayez d'�tiqueter l'histogramme, l'axe des x et l'axe des y et donnez � l'histogramme la couleur violette.
hist(tourism$expenses, main="histogramme des d�penses",xlab="depense",ylab="frequence",col="violet")

#8.	Cr�ez un diagramme circulaire pour la variable �ducation et interpr�tez bri�vement le diagramme circulaire. Essayez d'ajouter les noms aux pi�ces.
pie(table(tourism$education),main="Diagramme circulaire d'education",labels=c("secondary school","A-levels","bachelor","master"))

#9.	Essayez de cr�er un diagramme � barres qui affiche les invit�s par pays et par cat�gorie d'h�bergement. Lab�liser correctement le diagramme � barres et interpr�tez le r�sultat.
barplot(table(tourism$country,tourism$accommodation),main="diagramme � barres",xlab ="invites par pays d'hebergement",ylab="fequence",args.legend =c("pays","hebergement"),col ="darkblue")

#10. Cr�ez une bo�te � moustaches qui montre les d�penses par pays des invit�s. Lab�lisez-la et interpr�tez les r�sultats.
boxplot(tourism$expenses~tourism$country, main="variation des depenses par pays des invites",xlab="pays",ylab="depenses",names= c("switzerland","germany","australie","other"))

#11.	Dessinez un diagramme de dispersion pour les variables �ge et d�penses. Lab�lisez-la et interpr�tez le r�sultat. Existe-t-il une relation lin�aire (ligne droite) entre les deux variables ?
plot(tourism$age,tourism$expenses, main="redondance entre age et depense", xlab="age", ylab="depense",col="orange")