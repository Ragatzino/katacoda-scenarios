Pour utiliser des donnees persistees ou demarrer sur donnees persistees, Docker a un concept : les volumes.

## Illustration avec le partage d'un dossier

Pour cet exemple nous allons partager un espace dans notre ubuntu avec un autre ubuntu, cette fois dockerisé.

L'option pour rajouter un volume permet de partager un sous espace de fichier entre le conteneur et l'hôte : ici notre ubuntu.

- Créons donc un espace partagé dans /root/espace-partage

`
mkdir /root/espace-partage
`{{execute}}

L'option volume s'utilise lors du lancement via docker run avec le tag **-v**

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

On peut aller le retrouver sur notre conteneur :
`
docker exec $ID_CONTENEUR ls /root/espace-partage/"
`{{execute}}

## Accès aux volumes :
Accédez a la liste des volumes docker

`
docker volume ls
`{{execute}}

Vous pouvez observer les détails pour chaque volume avec : 
`
docker inspect $ID_VOLUME
`

## Nettoyage, ou presque?

Que se passe-t-il quand le conteneur s'arrête ? => Vérifions cela
`
docker kill $ID_CONTENEUR
`{{execute}}

`
docker volume ls
`{{execute}}

`
docker rm $ID_CONTENEUR
`{{execute}}

>> Reste-t-il un volume ?  <<
( ) Non
(*) Oui

> Pour supprimer simplement le volume défini il faut faire la commande : 

`
docker volume rm <id-volume>
`
