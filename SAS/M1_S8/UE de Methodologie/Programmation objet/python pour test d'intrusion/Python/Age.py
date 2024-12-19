def determine_age_type(age):
    if age < 0:
        return "Invalid age"
    elif age <= 10:
        return "Child"
    elif 11 <= age <= 17:
        return "Teenager"
    elif 18 <= age <= 45:
        return "Young"
    elif age >= 46:
        return "Adult"

age = int(input("Entrez l'âge : "))
type_personne = determine_age_type(age)
print(f"L'âge {age} correspond à un {type_personne}.")