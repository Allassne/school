l = [10,4,-1,4,18,3,2]
print(l)
# 1) Ajoutez 23 à la 6eme position de la liste
l.insert(5, 23) 
print("Liste après ajout de 23 à la 6ème position :", l)

# 2) Affiche le nombre de notes supérieur ou égal à 4
#nbre_S_ou_egal_4 = sum(1 for note in l if note >= 4)
#print("Nombre de notes supérieur ou égal à 4 :", nbre_S_ou_egal_4)
print(len([x for x in l if x >= 4]))

# 3) Tri la liste par ordre décroissant
#l.sort(reverse=True)
ls = sorted(l, reverse=True)
print("Liste triée par ordre décroissant :", ls)

# 4) Créez l1 tel que l1 contient le carré des éléments de l qui sont pairs
l1 = [x**2 for x in l if x % 2 == 0]
print("l1 avec le carré des éléments pairs :", l1)

# 5) Créez l2 tel que l2 contient le double des éléments de l qui sont impairs
l2 = [x * 2 for x in l if x % 2 != 0]
print("l2 avec le double des éléments impairs :", l2)

# 6) Supprimer les nombres négatifs de l
l = [x for x in l if x >= 0]
print("Liste après suppression des nombres négatifs :", l)