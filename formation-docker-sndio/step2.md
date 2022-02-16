

### Testons une image toute simple

`
docker run hello-world
`{{execute}}

Cette image décrit tout le déroulement de son processus.

L'option -p permet de définir le port sur la machine hote ouvert sur le conteneur : un tomcat exposant sur le port 8080 par défaut

`
docker run -p 8080:8080 tomcat
`{{execute}}

> Cela expose le port 8080 du conteneur vers le port 8080 de la machine.

### Consultez les processus

`
ps
`{{execute}}

`
docker ps
`{{execute}}

