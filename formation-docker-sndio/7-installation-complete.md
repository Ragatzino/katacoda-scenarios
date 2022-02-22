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
  --name=postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_PASSWORD=mdp \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v /root/postgres/:/docker-entrypoint-initdb.d/ \
  -p 5433:5432 \
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
cat /root/formation/.env | cut -d "=" -f2 | python -m json.tool
`{{execute}}


> Une fois les properties a valoriser renseignées, on peut y aller ! 

`
docker run -d \
  --name=app \
  --env-file ./.env \
  -p 8080:8080 \
  app
`{{execute}}

## Test

Pour s'assurer que tout marche, regardons la liste des utilsateurs que l'api nous fournit
`
curl localhost:8080/users
`{{execute}}





