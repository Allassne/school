
# Representation du dictionnaire

bd={"Christian": '77355910',"Flore": '44412120', "Laurent": '07384121',"Iris": '03221327',"Antoine": '88456874'  }

print(bd.keys())

# Mettre a jour le dictionnaire

bd.update({'Laurent':" 08457820."})

print(bd)

# affichage du carnet d' adresse de Koffi

for cle,val in bd.items():
    print("{}:{}".format(cle,val))


