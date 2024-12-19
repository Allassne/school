while True:
    try:
        nombre = int(input("Entrez un nombre compris entre 0 et 20 : "))
        if 0 <= nombre <= 20:
            print(f"Vous avez entré le nombre valide : {nombre}")
            break
        else:
            print("Le nombre doit être compris entre 0 et 20. Veuillez réessayer.")
    except ValueError:
            print("Veuillez entrer un nombre valide.")