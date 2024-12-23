##############################################
##         R, UN LANGAGE VECTORIS�          ##
##                  Ao�t 2018               ##
##                                          ##
##                Manipuler                 ##
##          les vecteurs (vectors)          ##
##                                          ##
## Les vecteurs sont les objets les plus    ##
## utilis�s. Ce sont les variables que nous ##
## utilisons dans nos analyses.             ##
##                                          ##
## Le langage S permet d'�viter les boucles ##
## (FOR, WHILE,  LOOP, ...).                ##
##############################################

# code pour nettoyer la console de R.
#Identique � l'action "Ctrl + L" au clavier
cat('\f')


# Nouveau dossier de travail
setwd("C:/R_dossier/out")


# Chargement du fichier contenant tout les objets de l'exercice pr�c�dent
#  vecteur "a", fonction "f" et data frame "olympics.1996"
load(file = "Mon Fichier.RData")



##############################################
##         cr�ation des vecteurs            ##
##             PAS DE BOUCLE                ##
##############################################

# affichage du vecteur "a"
a

# cr�ation d'un vecteur "b"
b<-c(10,20,30,40,10)

# affichage du vecteur "b"
b


##############################################
##        Informations sur les vecteurs     ##
##                                          ##
##############################################


# Est-ce que "b" est un vecteur?
is.vector(b)


# Nature (type) des �l�ments du vecteur "b"
class(b)	# le vecteur b contient des �l�ments num�riques


# Structure du vecteur "b"
str(b)		# 5 �l�ments num�riques


# longueur du vecteur "b"
length(b)



##############################################
##    Quelques op�rations de basiques       ##
##            sur les vecteurs              ##
##                                          ##
##############################################


# notez la simplicit� du code.
# pas de boucle pour effectuer les op�rations sur chaque �l�ment
# affichage du vecteur "b"
b

2*b+1		# 2*b+1 sur chaque composante de b

b**2		# le carr� de chaque composante

sqrt(b)		# racine carr� de chaque composante

log(b)		# log de chaque composante


# quelques fonctions de base (pas de boucle)
# simplicit� du code

sum(b)		# somme

mean(b)		# moyenne

min(b)		# minimum

max(b)		# maximum

sd(b)		  # �cart-type des �l�ments

median(b)	# m�dianne des �l�ments

mean(b)   # moyenne des �l�ments

cumsum(b)	# somme cumul� des �l�ments

cumprod(b)# produit cumul� des �l�ments

cummax(b)	# maximum au fur et � mesure de la lecture des �l�ments

cummin(b)	# minimum au fur et � mesure de la lecture des �l�ments

all(b>5)	# tous les �l�ments du vecteurs sont-ils plus grand que 5?

any(b<5)	# y a-t-il au moins un �l�ment plus petit que 5 ?


##############################################
##   Manipulation des indices de position   ##
##             PAS DE BOUCLE                ##
##############################################

# affiche le deuxi�me �l�ment du vecteur "b"
b[2]


# extrait les �l�ments du 3i�me au 5i�me du vecteur "b"
b[3:5]


# modifie le 4i�me �l�ment du vecteur "b"
b[4]<--5
b


# supprime le 2i�me �l�ment du vecteur "b"
b<-b[-2]
b


# ajoute un 10i�me �l�ment du vecteur "b".
# notez les "NA" signifiant "Not Available" (Indisponible = Vide)
b[10]<-100
b

# affiche les �l�ments du vecteur "b" sup�rieur ou �gal � 20
b[b>=20]


# retour les indices (position) des �l�ments du vecteur "b" �gaux � 10
which(b==10)


# indice du plus grand �l�ment dans le vecteur "b"
# identique : ==		diff�rent : !=
# strict sup�rieur : >	strict inf�rieur : <
# sup�rieur ou �gale : >=	inf�rieur ou �gal : <=
# Dans cet exemple, on ne pourra pas obtenir l'indice
# de l'�l�ment le plus grand car il y a des "NA".
b
which(b==max(b))


# ins�re un nouvel �l�ment dans le vecteur "b"
# ins�re en 3i�me position la valeur "4"
b
b<-c(b[1:2],4,b[3:10]) 	
b


##############################################
##  Petite statistique sur la variable "b"  ##
##             ATTENTION au NA              ##
##############################################

# Compte le nombre de NA (donn�es non disponibles) dans le vecteur "b"
# is.na(...) retour une valeur TRUE ou FALSE, (et TRUE=1, FALSE=0)
b
sum(is.na(b))


# D�termine les donn�es extr�mes du vecteur "b"
# les valeurs NA (Not Available) sont prises en compte
range(b)


# D�termine les donn�es extr�mes sans tenir compte des NA
# De nombreux bugs proviennent du mauvais traitement des NA
# na.rm(...) permet de supprimer du traitement, les �l�ments NA
range(b, na.rm=TRUE)


# Aspect de la distribution des valeurs, les quartiles (min=0%, Q1=25%, Medianne=50%, Q3=75%, max=100%)
# Ne pas oublier, nous avons des NA
quantile(b, na.rm=TRUE)


# R�sum� rapide (les quartiles et la moyenne)
summary(b, na.rm=TRUE)


# Quantiles (0%, 10%, 90%, 100%)
quantile(b, probs=c(0,0.1,0.9,1), na.rm=TRUE)


# affiche les �l�ments du vecteur "b" sup�rieur ou �gal � 20 sans les NA
# le point d'exclamation est l'op�rateur: NON (inverseur)
# l'op�rateur ET : &
# l'op�rateur OU : |
b[b>20]
b[b>20 & !is.na(b)]



##############################################
##           Suppression des  NA            ##
##             ATTENTION au NA              ##
##############################################

# Affiche les �l�ments qui sont NA
b[is.na(b)]


# suprime les valeurs non disponibles du vecteur "b"
# le point d'exclamation est l'op�rateur NON (inverseur)
b<-b[!is.na(b)]
b


# modifie et ajoute du 5i�me au 9i�me �l�ment de "b", la valeur 1
b[5:10]<- 1
b


##############################################
##           Tri sur les vecteurs           ##
##    GARDEZ TOUJOURS LE VECTEUR INITIAL    ##
##############################################


# Affiche le tri croissant du vecteur "b"
sort(b)
# Warning, "b" n'est pas trier, il faut affecter le r�sultat du tri (b<-sort(b)).
b


# Affiche le tri d�croissant du vecteur "b"
sort(b,decreasing = TRUE)
# Warning, "b" n'est pas trier, il faut affecter le r�sultat du tri (b<-sort(b)).
b


# Position (classement) des �l�ments du tri croissant du vecteur "b"
b
order(b)
# Remarquez: il n'y a pas d'ex �quo.
# C'est l'odre d'apparition qui d�termine les �quos. 


# Position (classement) des �l�ments du tri croissant du vecteur "b"
b
rank(b,ties.method = "min")
# Remarquez: On passe de la position 2 � 8



##############################################
##     Fonctions sur plusieurs vecteurs     ##
##          TOUJOURS PAS DE BOUCLE          ##
##############################################

# les op�rations de base, membre � memebre entre les deux vecteurs "a" et "b"
a+b
a-b
a/b
a*b


# plus grand �l�ment, membre � membre entre deux vecteurs "a" et "b"
a
b
pmax(a,b)


# plus petit �l�ment, membre � membre entre deux vecteurs "a" et "b"
a
b
pmin(a,b)


# plus grand �l�ment dans les deux vecteurs "a" et "b"
max(a,b)



# corr�lation lin�aire entre deux vecteurs "a" et "b" pour avoir un aper�u de la d�pendance
# Les deux vecteurs doivent avoir la m�me longueur
cor(a,b)



##############################################
##        Cr�ation d'un dictionnaire        ##
##                CLE, VALEUR               ##
##                                          ##
##          TOUJOURS PAS DE BOUCLE          ##
##############################################

# ajoute des cl�s au vecteurs "b"
names(b)<-c("Fr","Sp","Uk","Pl","It","De","Ir","Po", "Ca", "Us")

# affiche le vecteur "b" (cl�, valeur)
b

# retour le valeur pour la cl� "Sp"
b["Sp"]


# extrait les cl�s dont la valeurs est sup�rieur � 10
b[b>10]


# retour l'�l�ment(cl�, valeur) en 2i�me position
b[2]


# retour tout les �l�ments tri�s par ordre alphab�tique de la cl�
b[sort(names(b))]


# retour tout les �l�ments dont la cl� est alphab�tiquement plus grand que "K"
b[names(b)>"K"]


# on peut toujours utiliser toutes les fonctions des vecteurs
# par exemple : pmax(a,b) ou a*b
pmax(a,b)
a*b



##############################################
##      Chargement d'un fichier .sav        ##
##  contenant 2 vecteurs de type "facteur"  ##
##          vecteur: pr�noms.2004           ##
##          vecteur: pr�noms.2014           ##
##                                          ##
##   Source : https://www.data.gouv.fr      ##
##############################################

# Chargement d'un fichier de donn�es contenant le vecteur "prenoms"
load(file = "prenoms.sav")

# nature des �l�ments des vecteurs "prenoms"
class(prenoms.2004)
class(prenoms.2014)


# structure des vecteurs "prenoms"
str(prenoms.2004)
str(prenoms.2014)


# longueur des vecteurs "prenoms"
length(prenoms.2004)
length(prenoms.2014)


# il y a des pr�noms qui sont en doublons
# cr�ation de 2 vecteurs contenant que des pr�noms uniques (distincts)
unique.2004<-unique(prenoms.2004)
unique.2014<-unique(prenoms.2014)


# longueur des vecteurs "prenoms"
length(unique.2004)
length(unique.2014)


# ensemble des pr�noms sans doublon
ensemble<-union(prenoms.2004,prenoms.2014)


# les pr�noms qui sont pr�sents dans les deux vecteurs sans doublon
commun<-intersect(prenoms.2004,prenoms.2014)


# diff�rence en 2004 par rapport � 2014
# les diff�rences ne sont pas sym�triques
# correspond aux pr�noms de 2004 qui ne sont pas pr�sents en 2014
diff2004_2014<- setdiff(prenoms.2004,prenoms.2014)


# diff�rence en 2014 par rapport � 2004
# les diff�rences ne sont pas sym�triques
# correspond au nouveaux pr�noms en 2014 par rapport � 2004
diff2014_2004<- setdiff(prenoms.2014,prenoms.2004)



##############################################
##              APPARTENANCE                ##
##               D'ELEMENTS                 ##
##############################################

# Outil extr�mement puissant qui v�rifie l'existence
# d'�l�mnets dans un vecteur

# Exist-il un �l�ment "10" dans le vecteur "b"
b%in%10

# Exist-il un �l�ment "10" et "4" dans le vecteur "b"
b%in%c(10,4)

# on pr�f�re utiliser les indices car les vecteurs sont souvent grand
which(b%in%c(10,4))

# on peut avoir les �l�ments en commun entre deux vecteurs
b[which(b%in%a)]

# Attention � la CASE
which(prenoms.2014%in%"anne")
which(prenoms.2014%in%"Anne")

# D�termine les pr�noms pr�sents entre 2014 et d�j� pr�sent en 2014
Pr�nomsD�j�PresentEn.2004<-prenoms.2014[which(prenoms.2014%in%prenoms.2004)]
length(Pr�nomsD�j�PresentEn.2004)


##############################################
##           SAUVEGARDE DES OBJETS          ##
##          DE L'ENVIRONNEMENT GLOBAL       ##
##                                          ##
##             EFFACER DES OBJETS           ##
##############################################

# efface la fonction f(), les vecteurs a, b, unique.2004, unique.2014 et ensemble
rm(f,a,b,unique.2004, unique.2014, ensemble)

# sortie au format CSV de la liste des nouveaux pr�noms  2014
write.csv(x = diff2014_2004,file = "liste nouveaux pr�noms 2014.csv")


# Sauvegarde de tout les objets dans le fichier "Mon Fichier.RData"
save(list = ls(),file = "Mon Fichier TD2.RData")
