Pour utiliser des donnees persistees ou demarrer sur donnees persistees, Docker a un concept : les volumes.

## Illustration avec le partage d'un dossier

Pour cet exemple nous allons partager un espace dans notre ubuntu avec un autre ubuntu, cette fois dockerisé.

L'option pour rajouter un volume permet de partager un sous espace de fichier entre le conteneur et l'hôte : ici notre ubuntu.

`
mkdir /root/espace-partage
`{{execute}}

Cette option s'utilise lors du lancement avec le tag **-v**

Essayez :
`
docker run -d -v  /root/espace-partage:/root/espace-partage ubuntu \
bin/bash -c "while true; do echo hello world; sleep 1; done"
`{{execute}}

Maintenant si l'on crée un fichier sur notre machine :
`
echo "message" > /root/espace-partage/message.txt
`{{execute}}

On peut aller le retrouver sur notre conteneur :
`
docker exec $ID_CONTENEUR ls /root/espace-partage/"
`{{execute}}

## Accès plus générique au volumes :
Accédez a la liste des volumes docker
`
docker volume ls
`{{execute}}

Vous pouvez observer les détails pour chaque volume avec : 
`
docker inspect <id-du-volume>
`

## Nettoyage, ou presque?

Est ce que le fichier reste avec l'image ? => Vérifions cela
`
docker kill $ID_CONTENEUR
`

`
docker volume ls
`{{execute}}

`
docker rm $ID_CONTENEUR
`

>> Reste-t-il un volume ?  <<
( ) Non
(*) Oui

> Pour supprimer simplement le volume défini il faut faire la commande : 

`
docker volume rm <id-volume>
`

