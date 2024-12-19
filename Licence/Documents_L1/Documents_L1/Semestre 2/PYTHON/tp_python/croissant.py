A
# creation du jeu plus ou moins

from random import choice

nombres=[]

for i in range(1,100):

    nombres.insert(i,i)

coups=0

mystere=choice(nombres)


pseudo=input("Entrer votre pseudo")


choix=int(input("Entrer un nombre compris entre 1 et 100"))

while  choix<0 or choix>100:

    choix=int(input("Veuillez changer de nombre !!(nombre incompris dans l'intervalle)"))


while choix!=mystere:

    coups+=1

    if choix<mystere:

        print("c' est plus !!")

        choix = int(input("Veuillez changer de nombre"))

    else:
        print("c' est moins !!")

        choix = int(input("Veuillez changer de nombre"))


print("Bravo {} vous avez gagner  en {} coups !!".format(pseudo,coups))

# on peut utiliser randint pour entrer l' intervalle directement

#Amelioration du jeu ajouter un  fichier pour les meilleurs coups

#compter le nombre de coups