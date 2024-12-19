projet = {"Prince", "Maëlys", "Ferdinand", "Melissa", "Luc", "Olivier"}
examen = {"Anne", "Ami", "Prince", "Luc", "Ferdinand"}

# 1) Afficher la liste des étudiants qui ont passé l'examen et soumis le projet
#etudiants_exam_et_projet = projet & examen
etudiants_exam_et_projet = projet.intersection(examen)

print("Étudiants ayant passé l'examen et soumis le projet :", etudiants_exam_et_projet)

# 2) Afficher la liste des étudiants qui ont passé l'examen ou soumis le projet ou les deux
# etudiants_exam_ou_projet = projet | examen
etudiants_exam_ou_projet = projet.union(examen)
print("Étudiants ayant passé l'examen ou soumis le projet ou les deux :", etudiants_exam_ou_projet)
  
# 3) Afficher la liste des étudiants qui ont passé uniquement l'examen
#etudiants_uniquement_exam = examen - projet
etudiants_uniquement_exam = examen.difference(projet)
print("Étudiants ayant passé uniquement l'examen :", etudiants_uniquement_exam)

# 4) Afficher la liste des étudiants qui ont soumis uniquement le projet
#etudiants_uniquement_projet = projet - examen
etudiants_uniquement_projet = projet.difference(examen)
print("Étudiants ayant soumis uniquement le projet :", etudiants_uniquement_projet)

# 5) Afficher la liste des étudiants qui ont passé l'examen ou le projet mais pas les deux
#etudiants_exam_ou_projet_pas_les_deux = (projet | examen) - (projet & examen)
etudiants_exam_ou_projet_pas_les_deux = (projet.symmetric_difference(examen))
print("Étudiants ayant passé l'examen ou le projet mais pas les deux :", etudiants_exam_ou_projet_pas_les_deux)