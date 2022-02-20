### Accéder a la présentation

- LIEN VERS LA PRESENTATION

### Execution d'images

Commençons par executer une image docker de base : 

`
docker run hello-world
`{{execute}}

Cette image décrit tout le déroulement de sa récupération a son execution.
### Quelques options

Le numéro après le **:** permet de définir la version. (voir https://hub.docker.com/_/tomcat) par exemple.

L'option -p permet de définir le port sur la machine hote ouvert sur le conteneur : un tomcat exposant sur le port 8080 par défaut

`
docker run -p 8080:8080 tomcat:9.0
`{{execute}}

> Cela expose le port 8080 du conteneur vers le port 8080 de la machine.

L'option -d permet de lancer un conteneur sur la machine en arrière plan.

`
docker run -d -p 8888:8080 tomcat:9.0
`{{execute}}

### Consultez les processus

`
ps
`{{execute}}

`
docker ps
`{{execute}}

### Exécuter du code sur un conteneur
Vous pouvez executez du code sur des conteneurs avec la commande **exec**
et l'option -it permet de passer en mode interactif sur une conteneur
Testez par exemple:

`
docker exec <id-du-tomcat> cat README.md
`

`
docker exec -it <id-du-tomcat> bash
`
(ne fonctionne que si l'image à bash, évidemment)

>> Question : combien y a-t-il de fichiers dans ./webapps dans le conteneur après son démarrage? <<
=== 0
