def table_de_multiplication(nombre, max_multiplicateur=10):
    for i in range(1, max_multiplicateur + 1):
        resultat = nombre * i
        print(f"{nombre} x {i} = {resultat}")

nombre = int(input("Entrez un nombre pour afficher sa table de multiplication : "))
table_de_multiplication(nombre)
