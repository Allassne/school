import pygame
pygame.init()

#cretion d' une classe qui va representer le joueur


class Player(pygame.sprite.Sprite):

    def _init_(self):

        super().__init__()
        self.health = 100
        self.max_health = 100
        self.attack = 10
        self.velocity = 5





image = pygame.image.load("assets/player.png").convert()
rect = self.image.get_rect()
#creation de la fenetre de jeu

pygame.display.set_caption("berserk")

screen= pygame.display.set_mode((1080,600))

# mise en place de l' arriere plan du jeu

background=pygame.image.load('assets/bg.jpg')

#charger notre joueur

player = Player()






#cretion d'une boucle infinie

running=True



#Mise en place de la boucle infinie

while running:
    screen.blit(background,(0,-303))

#appliquer l' image du joueur

    screen.blit(player.image,player.rect)

#mettre a jour l' ecran

    pygame.display.flip()


    # mise en place d' une condition pour permettre a l' utilisateur de fermer la fenetre de jeu

    for event in pygame.event.get():


        if event.type == pygame.QUIT:


            running=False

            pygame.quit()

            print("Fermeture du jeu")
