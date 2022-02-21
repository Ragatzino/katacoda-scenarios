Pour utiliser des donnees persistees ou demarrer sur donnees persistees, Docker a un concept : les volumes.

## Montage : Illustration avec le partage d'un dossier 

Pour cet exemple nous allons partager un espace dans notre ubuntu avec un autre ubuntu, cette fois dockerisé.

L'option pour rajouter un volume permet de partager un sous espace de fichier entre le conteneur et l'hôte : ici notre ubuntu.

- Créons donc un espace partagé dans /root/espace-partage

`
mkdir /root/espace-partage
`{{execute}}

L'option pour monter un volume s'utilise lors du lancement via docker run avec le tag **-v**

Essayez :
`
ID_CONTENEUR=$(docker run -d \
-v  /root/espace-partage:/root/espace-partage \
ubuntu \
bin/bash -c "while true; do echo hello world; sleep 1; done")
`{{execute}}

> Remarque : on a ici variabilisé l'id_conteneur pour plus de practicité


Maintenant si l'on crée un fichier sur notre machine :
`
echo "message" > /root/espace-partage/message.txt
`{{execute}}

Que l'on retrouve par exemple avec la commande ls :
`
ls /root/espace-partage/
`{{execute}}

On peut aller le retrouver sur notre conteneur :
`
docker exec $ID_CONTENEUR ls /root/espace-partage/
`{{execute}}

## Docker volumes

Docker prévoit un espace spécifique ou stocker des volumes, utilisables par nom : /var/lib/docker/volumes.

Vous pouvez créer un volume avec la commande : 
`
 docker volume create ubuntu_partage
`{{execute}}

`
docker run -d \
-v  ubuntu_partage:/root/espace-partage \
ubuntu \
bin/bash -c "while true; do echo hello world; sleep 1; done"
`{{execute}}


Accédez a la liste des volumes docker

`
docker volume ls
`{{execute}}



Vous pouvez observer les détails pour chaque volume avec :

`
docker inspect $NOM_VOLUME
`

exemple :
`
docker inspect ubuntu_partage
`{{execute}}


