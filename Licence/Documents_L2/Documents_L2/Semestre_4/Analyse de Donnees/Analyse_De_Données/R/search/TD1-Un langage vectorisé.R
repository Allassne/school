##############################################
##         R, UN LANGAGE VECTORISÉ          ##
##                  Août 2018               ##
##                                          ##
##                Manipuler                 ##
##          les vecteurs (vectors)          ##
##                                          ##
## Les vecteurs sont les objets les plus    ##
## utilisés. Ce sont les variables que nous ##
## utilisons dans nos analyses.             ##
##                                          ##
## Le langage S permet d'éviter les boucles ##
## (FOR, WHILE,  LOOP, ...).                ##
##############################################

# code pour nettoyer la console de R.
#Identique à l'action "Ctrl + L" au clavier
cat('\f')


# Nouveau dossier de travail
setwd("C:/R_dossier/out")


# Chargement du fichier contenant tout les objets de l'exercice précédent
#  vecteur "a", fonction "f" et data frame "olympics.1996"
load(file = "Mon Fichier.RData")



##############################################
##         création des vecteurs            ##
##             PAS DE BOUCLE                ##
##############################################

# affichage du vecteur "a"
a

# création d'un vecteur "b"
b<-c(10,20,30,40,10)

# affichage du vecteur "b"
b


##############################################
##        Informations sur les vecteurs     ##
##                                          ##
##############################################


# Est-ce que "b" est un vecteur?
is.vector(b)


# Nature (type) des éléments du vecteur "b"
class(b)	# le vecteur b contient des éléments numériques


# Structure du vecteur "b"
str(b)		# 5 éléments numériques


# longueur du vecteur "b"
length(b)



##############################################
##    Quelques opérations de basiques       ##
##            sur les vecteurs              ##
##                                          ##
##############################################


# notez la simplicité du code.
# pas de boucle pour effectuer les opérations sur chaque élément
# affichage du vecteur "b"
b

2*b+1		# 2*b+1 sur chaque composante de b

b**2		# le carré de chaque composante

sqrt(b)		# racine carré de chaque composante

log(b)		# log de chaque composante


# quelques fonctions de base (pas de boucle)
# simplicité du code

sum(b)		# somme

mean(b)		# moyenne

min(b)		# minimum

max(b)		# maximum

sd(b)		  # écart-type des éléments

median(b)	# médianne des éléments

mean(b)   # moyenne des éléments

cumsum(b)	# somme cumulé des éléments

cumprod(b)# produit cumulé des éléments

cummax(b)	# maximum au fur et à mesure de la lecture des éléments

cummin(b)	# minimum au fur et à mesure de la lecture des éléments

all(b>5)	# tous les éléments du vecteurs sont-ils plus grand que 5?

any(b<5)	# y a-t-il au moins un élément plus petit que 5 ?


##############################################
##   Manipulation des indices de position   ##
##             PAS DE BOUCLE                ##
##############################################

# affiche le deuxième élément du vecteur "b"
b[2]


# extrait les éléments du 3ième au 5ième du vecteur "b"
b[3:5]


# modifie le 4ième élément du vecteur "b"
b[4]<--5
b


# supprime le 2ième élément du vecteur "b"
b<-b[-2]
b


# ajoute un 10ième élément du vecteur "b".
# notez les "NA" signifiant "Not Available" (Indisponible = Vide)
b[10]<-100
b

# affiche les éléments du vecteur "b" supérieur ou égal à 20
b[b>=20]


# retour les indices (position) des éléments du vecteur "b" égaux à 10
which(b==10)


# indice du plus grand élément dans le vecteur "b"
# identique : ==		différent : !=
# strict supérieur : >	strict inférieur : <
# supérieur ou égale : >=	inférieur ou égal : <=
# Dans cet exemple, on ne pourra pas obtenir l'indice
# de l'élément le plus grand car il y a des "NA".
b
which(b==max(b))


# insére un nouvel élèment dans le vecteur "b"
# insère en 3ième position la valeur "4"
b
b<-c(b[1:2],4,b[3:10]) 	
b


##############################################
##  Petite statistique sur la variable "b"  ##
##             ATTENTION au NA              ##
##############################################

# Compte le nombre de NA (données non disponibles) dans le vecteur "b"
# is.na(...) retour une valeur TRUE ou FALSE, (et TRUE=1, FALSE=0)
b
sum(is.na(b))


# Détermine les données extrêmes du vecteur "b"
# les valeurs NA (Not Available) sont prises en compte
range(b)


# Détermine les données extrêmes sans tenir compte des NA
# De nombreux bugs proviennent du mauvais traitement des NA
# na.rm(...) permet de supprimer du traitement, les éléments NA
range(b, na.rm=TRUE)


# Aspect de la distribution des valeurs, les quartiles (min=0%, Q1=25%, Medianne=50%, Q3=75%, max=100%)
# Ne pas oublier, nous avons des NA
quantile(b, na.rm=TRUE)


# Résumé rapide (les quartiles et la moyenne)
summary(b, na.rm=TRUE)


# Quantiles (0%, 10%, 90%, 100%)
quantile(b, probs=c(0,0.1,0.9,1), na.rm=TRUE)


# affiche les éléments du vecteur "b" supérieur ou égal à 20 sans les NA
# le point d'exclamation est l'opérateur: NON (inverseur)
# l'opérateur ET : &
# l'opérateur OU : |
b[b>20]
b[b>20 & !is.na(b)]



##############################################
##           Suppression des  NA            ##
##             ATTENTION au NA              ##
##############################################

# Affiche les éléments qui sont NA
b[is.na(b)]


# suprime les valeurs non disponibles du vecteur "b"
# le point d'exclamation est l'opérateur NON (inverseur)
b<-b[!is.na(b)]
b


# modifie et ajoute du 5ième au 9ième élément de "b", la valeur 1
b[5:10]<- 1
b


##############################################
##           Tri sur les vecteurs           ##
##    GARDEZ TOUJOURS LE VECTEUR INITIAL    ##
##############################################


# Affiche le tri croissant du vecteur "b"
sort(b)
# Warning, "b" n'est pas trier, il faut affecter le résultat du tri (b<-sort(b)).
b


# Affiche le tri décroissant du vecteur "b"
sort(b,decreasing = TRUE)
# Warning, "b" n'est pas trier, il faut affecter le résultat du tri (b<-sort(b)).
b


# Position (classement) des éléments du tri croissant du vecteur "b"
b
order(b)
# Remarquez: il n'y a pas d'ex æquo.
# C'est l'odre d'apparition qui détermine les æquos. 


# Position (classement) des éléments du tri croissant du vecteur "b"
b
rank(b,ties.method = "min")
# Remarquez: On passe de la position 2 à 8



##############################################
##     Fonctions sur plusieurs vecteurs     ##
##          TOUJOURS PAS DE BOUCLE          ##
##############################################

# les opérations de base, membre à memebre entre les deux vecteurs "a" et "b"
a+b
a-b
a/b
a*b


# plus grand élément, membre à membre entre deux vecteurs "a" et "b"
a
b
pmax(a,b)


# plus petit élément, membre à membre entre deux vecteurs "a" et "b"
a
b
pmin(a,b)


# plus grand élément dans les deux vecteurs "a" et "b"
max(a,b)



# corrélation linéaire entre deux vecteurs "a" et "b" pour avoir un aperçu de la dépendance
# Les deux vecteurs doivent avoir la même longueur
cor(a,b)



##############################################
##        Création d'un dictionnaire        ##
##                CLE, VALEUR               ##
##                                          ##
##          TOUJOURS PAS DE BOUCLE          ##
##############################################

# ajoute des clés au vecteurs "b"
names(b)<-c("Fr","Sp","Uk","Pl","It","De","Ir","Po", "Ca", "Us")

# affiche le vecteur "b" (clé, valeur)
b

# retour le valeur pour la clé "Sp"
b["Sp"]


# extrait les clés dont la valeurs est supérieur à 10
b[b>10]


# retour l'élément(clé, valeur) en 2ième position
b[2]


# retour tout les éléments triés par ordre alphabétique de la clé
b[sort(names(b))]


# retour tout les éléments dont la clé est alphabétiquement plus grand que "K"
b[names(b)>"K"]


# on peut toujours utiliser toutes les fonctions des vecteurs
# par exemple : pmax(a,b) ou a*b
pmax(a,b)
a*b



##############################################
##      Chargement d'un fichier .sav        ##
##  contenant 2 vecteurs de type "facteur"  ##
##          vecteur: prénoms.2004           ##
##          vecteur: prénoms.2014           ##
##                                          ##
##   Source : https://www.data.gouv.fr      ##
##############################################

# Chargement d'un fichier de données contenant le vecteur "prenoms"
load(file = "prenoms.sav")

# nature des éléments des vecteurs "prenoms"
class(prenoms.2004)
class(prenoms.2014)


# structure des vecteurs "prenoms"
str(prenoms.2004)
str(prenoms.2014)


# longueur des vecteurs "prenoms"
length(prenoms.2004)
length(prenoms.2014)


# il y a des prénoms qui sont en doublons
# création de 2 vecteurs contenant que des prénoms uniques (distincts)
unique.2004<-unique(prenoms.2004)
unique.2014<-unique(prenoms.2014)


# longueur des vecteurs "prenoms"
length(unique.2004)
length(unique.2014)


# ensemble des prénoms sans doublon
ensemble<-union(prenoms.2004,prenoms.2014)


# les prénoms qui sont présents dans les deux vecteurs sans doublon
commun<-intersect(prenoms.2004,prenoms.2014)


# différence en 2004 par rapport à 2014
# les différences ne sont pas symétriques
# correspond aux prénoms de 2004 qui ne sont pas présents en 2014
diff2004_2014<- setdiff(prenoms.2004,prenoms.2014)


# différence en 2014 par rapport à 2004
# les différences ne sont pas symétriques
# correspond au nouveaux prénoms en 2014 par rapport à 2004
diff2014_2004<- setdiff(prenoms.2014,prenoms.2004)



##############################################
##              APPARTENANCE                ##
##               D'ELEMENTS                 ##
##############################################

# Outil extrêmement puissant qui vérifie l'existence
# d'élémnets dans un vecteur

# Exist-il un élément "10" dans le vecteur "b"
b%in%10

# Exist-il un élément "10" et "4" dans le vecteur "b"
b%in%c(10,4)

# on préfère utiliser les indices car les vecteurs sont souvent grand
which(b%in%c(10,4))

# on peut avoir les éléments en commun entre deux vecteurs
b[which(b%in%a)]

# Attention à la CASE
which(prenoms.2014%in%"anne")
which(prenoms.2014%in%"Anne")

# Détermine les prénoms présents entre 2014 et déjà présent en 2014
PrénomsDéjàPresentEn.2004<-prenoms.2014[which(prenoms.2014%in%prenoms.2004)]
length(PrénomsDéjàPresentEn.2004)


##############################################
##           SAUVEGARDE DES OBJETS          ##
##          DE L'ENVIRONNEMENT GLOBAL       ##
##                                          ##
##             EFFACER DES OBJETS           ##
##############################################

# efface la fonction f(), les vecteurs a, b, unique.2004, unique.2014 et ensemble
rm(f,a,b,unique.2004, unique.2014, ensemble)

# sortie au format CSV de la liste des nouveaux prénoms  2014
write.csv(x = diff2014_2004,file = "liste nouveaux prénoms 2014.csv")


# Sauvegarde de tout les objets dans le fichier "Mon Fichier.RData"
save(list = ls(),file = "Mon Fichier TD2.RData")
