Nous allons maintenant installer cette application 
## Interface entre une application spring boot et une base postgres

Mettons en lien l'application packagée en seconde partie de formation avec la base postgres.

De quoi avons nous besoin ? 
- Une base postgresql accessible sur le port 5432, qui a chargée un script en entrée
- Un tomcat qui connait cette base de données et y accède

## Base de données

Pour la base de données, il s'agit de la fin de la précédente page de la formation : 

`
docker run -d \
  --name=postgres-app \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_PASSWORD=mdp \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v /root/postgres/:/docker-entrypoint-initdb.d/ \
  -p 5432:5432 \
  postgres:11
`{{execute}}

## Tomcat
Pour le tomcat, spring boot permet de valoriser les properties via variables d'environnement : testons avec SPRING_APPLICATION_JSON : https://docs.spring.io/spring-boot/docs/2.1.11.RELEASE/reference/html/boot-features-external-config.html


> Il s'agit là d'une version JSONIFIEE de vos properties, ça devrait vous dire quelque chose.

Nous récupérons cela du projet :
`
cat /root/formation/.env
`{{execute}}

En plus joli :

`
cat /root/formation/.env | grep SPRING_APPLICATION_JSON | cut -d "=" -f2 | python -m json.tool
`{{execute}}


> Une fois les properties a valoriser renseignées, on peut y aller ! 

`
docker run -d \
  --name=tomcat-app \
  --env-file ./.env \
  -p 8080:8080 \
  app
`{{execute}}

Vous pouvez suivre le demarrage de l'appli : 
`
docker logs -f tomcat-app
`{{execute}}

## Test

Pour s'assurer que tout marche, regardons la liste des utilsateurs que l'api nous fournit
`
curl localhost:8080/users
`{{execute}}

<details>
<summary>Que se passe-t-il ?</summary>
    <p>

## Resolution

Le tomcat ne voit pas le postgres sur **localhost:5432**, c'est normal. Le postgres expose son port 5432 en local et pas au tomcat.

Il faut donc creer un reseau :
`
docker network create reseau-partage
`{{execute}}

Supprimer les conteneurs qui tournent actuellement :
`
docker kill postgres-app
docker rm postgres-app
docker kill tomcat-app
docker rm tomcat-app
`{{execute}}

Et les relancer sur le meme reseau partage avec l'option --net : 

**Postgres:**

`
docker run -d \
  --net reseau-partage \
  --name=postgres-app \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_PASSWORD=mdp \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v /root/postgres/:/docker-entrypoint-initdb.d/ \
  -p 5432:5432 \
  postgres:11
`{{execute}}

**Tomcat:**

=> Il ne s'agit plus de localhost 5432 mais de reseau-partage.postgres-app

On a modifie le fichier .env en consequence :

`
cat /root/formation/.env.solution | grep SPRING_APPLICATION_JSON | cut -d "=" -f2 | python -m json.tool
`{{execute}}


`
docker run -d \
  --net reseau-partage \
  --name=tomcat-app \
  --env-file ./.env.solution \
  -p 8080:8080 \
  app
`{{execute}}



**Verification:**
`
curl localhost:8080/users
`{{execute}}


</details>