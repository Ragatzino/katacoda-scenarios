L'objectif de cette partie est l'execution d'images pour découvrir docker.
### Execution d'images

Commençons par executer une image docker de base : 

`
docker run hello-world
`{{execute}}

Cette image décrit tout le déroulement de sa récupération a son execution.
### Quelques options

**Choisir sa version :** 

Le numéro après le **:** permet de définir la version. (voir https://hub.docker.com/_/tomcat) par exemple tomcat:9-jre11 => 9-jre11 = java 11, tomcat 9.

Des versions plus légères (slim) existent également.

**Choix du port :** 

L'option -p permet de définir le port sur la machine hote ouvert sur le conteneur : un tomcat exposant sur le port 8080 par défaut

`
docker run -p 8080:8080 tomcat:9-jre11
`{{execute}}

> Cela expose le port 8080 du conteneur vers le port 8080 de la machine.

L'option -d permet de lancer un conteneur sur la machine en arrière plan.
=> Cette option fait que l'on retourne l'id du conteneur

`
docker run -d -p 8888:8080 tomcat:9-jre11
`{{execute}}

On construira parfois la variable ID_CONTENEUR a partir de l'id qui nous est retourné après le lancement d'un conteneur

`
ID_CONTENEUR=$(\
docker run -d -p 8999:8080 tomcat:9-jre11 \
)
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

Il est de la forme :
`
docker exec ID_CONTENEUR <commande-dans-le-conteneur>
`

> Cela renvoie le resultat sur la machine hôte: notre ubuntu ici.

**Testez par exemple:**

`
docker exec $ID_CONTENEUR cat README.md
`{{execute}}

`
docker exec -it $ID_CONTENEUR bash
`{{execute}}

- (ne fonctionne que si l'image à bash, évidemment)

>> Question : combien y a-t-il de fichiers dans ./webapps dans le conteneur après son démarrage? <<
=== 0
