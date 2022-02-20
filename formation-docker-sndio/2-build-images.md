## Packager une application : Une image docker

Docker propose un système de construction personnalisées d'image docker : 

Plusieurs principes : 
- Construire un environnement isolé du reste 
- Isoler tout ce qui est nécessaire au fonctionnement du processus dans cet environnement
- Permettre l'installation de l'application en une commande : **docker run <nom-image>**

Il faut comprendre que l'on part toujours d'un environnement existant pour créer un environnement cible et donc souvent :
- Une distribution linux
- Un environnement qui part de cet environnement et dispose des ressources pour faire tourner l'application (scripts de démarrage et binaires)

=> On part souvent d'une image "haut niveau" en y rajoutant un petit script

## Exemple avec un serveur statique hébergeant une page HTML

- On est parti d'une image permettant de faire tourner un serveur apache qui vient de [dockerhub](https://hub.docker.com/_/httpd)
- Un dossier apache/ a été crée a la racine de votre environnement il contient la définition du Dockerfile et un fichier index.html servant d'exemple

`
cat apache/public-html/index.html
`{{execute}}


`
cat apache/Dockerfile
`{{execute}}


Le Dockerfile propose ici, (comme indiqué dans la doc sur DockerHub), de copier ses fichiers dans /usr/local/apache2/htdocs/

Construire une image revient a l'utilisation de la commande docker build : 

`
docker build -t monapache ./apache/
`{{execute}}

- [docker build documentation](https://docs.docker.com/engine/reference/commandline/build/)
- La balise -t permet de nommer son image docker

- Le dernier argument est l'emplacement du fichier Dockerfile, à partir duquel on va créer l'image
=> C'est équivalent a se déplacer sur ./apache et a faire : docker build -t monapache .

## Lancez votre application
Encore une fois on va lancer l'application, elle tourne sur le port 8080 dans le container
`
docker run -dit --name apache-test -p 8080:80 monapache
`{{execute}}