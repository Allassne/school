# creation de liste qui contient une serie de nombre

from  statistics import mean

var = []

notes = [9, 7, 7, 10, 3, 9, 6, 6, 2]

nb = 0

# Mise en place d' une boucle qui va compter le nombre de 7 dans la liste

for number in notes:

    if number == 7:
        nb += 1

print("Le nombre de 7 dans la liste est {}".format(nb))

# question 2

nombre = int(input("entrer  le nombre 4"))

notes[8] = nombre

print(notes)

# Question 3

# creation d' une boucle qui permet de trouver la note maximale de la liste

max = notes[0]

for number in notes:

    if number > max:
        max = number

# on peut utiliser une fonction max

print("La note maximale dans la liste est: {}".format(max))

# Question 4

notes.sort()

print(notes)

#Question 5

notes.sort(reverse=True)

print(notes)


#Question 6

# La fonction mean permet de calculer la moyenne

moy=mean(notes)

print(moy)