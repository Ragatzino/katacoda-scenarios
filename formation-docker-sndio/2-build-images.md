Cette partie consiste en la construction d'une image docker, pour prendre en main les notions de construction, nous feront un cas simple : un site html statique.

## Packager une application : Une image docker

Docker propose un système de construction personnalisées d'image docker : 

Plusieurs principes : 
- Construire un environnement isolé du reste 
- Isoler tout ce qui est nécessaire au fonctionnement du processus dans cet environnement
- Permettre l'installation de l'application en une commande : **docker run <nom-image>**

Il faut comprendre que l'on part toujours d'un environnement existant pour créer un environnement cible et donc souvent :
- Une distribution linux
- Un environnement qui part de cet environnement et dispose des ressources pour faire tourner l'application (scripts de démarrage et binaires)

=> On part souvent d'une image "haut niveau" en y rajoutant un petit script (on ne réinvente pas la roue)

## Exemple avec un serveur statique hébergeant une page HTML

- On est parti d'une image permettant de faire tourner un serveur apache qui vient de [dockerhub](https://hub.docker.com/_/httpd)
- Un dossier apache/ a été crée a la racine de votre environnement il contient la définition du Dockerfile et un fichier index.html servant d'exemple

`
cat /root/apache/public-html/index.html
`{{execute}}


`
cat /root/apache/Dockerfile
`{{execute}}


Le Dockerfile propose ici, (comme indiqué dans la doc sur DockerHub), de copier ses fichiers dans /usr/local/apache2/htdocs/

## Docker build
Documentation : https://docs.docker.com/engine/reference/commandline/build/

Construire une image revient a l'utilisation de la commande docker build : 

> La balise -t (tag) permet de nommer son image docker

> Le dernier argument est l'emplacement du fichier Dockerfile, à partir duquel on va créer l'image

`
docker build -t monapache /root/apache/
`{{execute}}

<details>
<summary>Alternative (cliquer pour voir)</summary>
    <p>

- Déplacement

`
cd /root/apache/
`{{execute}}

- Construction de l'image a partir de tout ce qu'on a à la racine

`
docker build -t monapache .
`{{execute}}

- Retour arrière

`
cd /root/
`{{execute}}


</p>
</details>

## Lancez votre application
Encore une fois on va lancer l'application, elle tourne sur le port 80 dans le conteneur

`
docker run -dit --name apache-test -p 8080:80 monapache
`{{execute}}

## Ajouter votre image a un registry
    
Le concept de registre d'image est simple, et vous en avez déjà utilisé un : dockerhub. 

Nous allons ici nous authentifier et rajouter notre image a dockerhub mais le fonctionnement serait le même avec tout autre registre (harbor interne par exemple)

Connectez vous via identifiant / mot de passe dockerhub avec la commande :
`
docker login
`{{execute}}

Il faut ensuite créer un tag pour que l'image soit envoyée au bon endroit :

`
docker tag monapache <user>/monapache:latest
`

et envoyer via push l'image taguée : 

`
docker push <user>/monapache:latest
`

(en remplaçant <user> par votre identifiant sur dockerhub)