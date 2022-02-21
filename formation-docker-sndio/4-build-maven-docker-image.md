Construction d'une image docker pour un tomcat.


### Création d'un war
Maven propose de générer un war par le stage : package 

`
mvn package
`{{execute}}


Une fois construit, on peut l'observer dans le repertoire target :

`
ls target/
`{{execute}}

### Dépot du war dans webapps : Pseudo script

Classiquement, il vous faut déposer un war dans /webapps d'un tomcat 9, java 11 pour qu'il lance l'application. Cela va être la même chose ici.

> Note: il est bien question d'aller chercher une ressource générée : le war. Il faut donc soit l'avoir construit avant (mvn package), soit aller la chercher sur un dépot (nexus par ex)

Pseudo script : 
- on partira donc d'un tomcat:9-jre11
- on exposera le port 8080 du tomcat par défaut (plutot que le port 80)
- on récupère le war qui est dans ./target et on le met dans $CATALINA_HOME/webapps/
- on relance le tomcat avec le script catalina.sh dans /bin avec l'argument **run**

> Remarque le war est un ROOT.war pour que le tomcat déploie l'appli sur /

### Dépot du war dans webapps : Dockerfile

Mot clés nécessaires (on les retrouve dans [la documentation](https://docs.docker.com/engine/reference/builder/)) : 
- FROM: départ d'une image
- EXPOSE 8080 : pour exposer le port 8080 par défaut sur le tomcat 
- COPY: copier un ou plusieurs fichiers
- CMD: executer un script ou une commande

<p>
<summary>Pseudo Dockerfile</summary>

```
FROM <image>
EXPOSE 8080
COPY <fichier> <fichier-cible>
CMD [<commande>, <arguments>]
```

</p><details>
<summary>Dockerfile (cliquer pour avoir la réponse)</summary>
    <p>

```
FROM tomcat:9-jre11
EXPOSE 8080
COPY target/*.war $CATALINA_HOME/webapps/
CMD ["catalina.sh","run"]
```

</p>
</details>

### Construction de l'image

Ajoutez le fichier Dockerfile créé a la racine de l'application puis construisez l'image avec docker build : 

`
docker build -t app .
`{{execute}}

et testez votre application

`
docker run -p 8080:8080 app
`{{execute}}

> Vous pouvez également la publier si vous le souhaitez (voir page précédente)