Le tomcat ne voit pas le postgres sur **localhost:5432**, c'est normal. Le postgres expose son port 5432 en local et pas au tomcat.

## Reseau : Utilisation du reseau de l'hote (machine)

On donne l'acces au reseau de l'hote pour les conteneurs (risque en production)

- On va donc supprimer les conteneurs qui tournent actuellement :

`
docker kill postgres-app
docker rm postgres-app
docker kill tomcat-app
docker rm tomcat-app
`{{execute}}

- Et les relancer en precisant qu'ils sont sur le reseau de l'hote a l'aide de l'option **--net**


**Postgres:**

`
docker run -d \
  --net host \
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

`
docker run -d \
  --net host \
  --name=tomcat-app \
  --env-file ./.env.solution \
  -p 8080:8080 \
  app
`{{execute}}

**Verification**:

`
curl localhost:8080/users
`{{execute}}

## Resolution 2 : defintion d'un reseau entre les 2 conteneurs

On se propose de creer un reseau partage entre les 2 (c'est ce que vous ferez en pratique) :

`
docker network create reseau-partage
`{{execute}}

- On va ensuite ressuprimer les conteneurs

`
docker kill postgres-app
docker rm postgres-app
docker kill tomcat-app
docker rm tomcat-app
`{{execute}}


- Et les relancer sur le meme reseau partage avec l'option --net <nom-reseau> : 

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

`
docker run -d \
  --net reseau-partage \
  --name=tomcat-app \
  --env-file ./.env \
  -p 8080:8080 \
  app
`{{execute}}


## **Verification:**

`
curl localhost:8080/users
`{{execute}}

=> Faisons une petite verification sur le conteneur tomcat

Y-a-t-il quelque chose sur localhost:5432 ?

`
docker exec tomcat-app ping localhost:5432
`{{execute}}

En fait, la base de donnees est nommee par le nom du conteneur:  postgres-app

`
docker exec tomcat-app ping postgres-app
`{{execute}}

## Finalisation 

- Suppression du tomcat
`
docker kill tomcat-app
docker rm tomcat-app
`{{execute}}

- Un nouveau fichier changeant la declaration de l'environnement est disponible sous /root/formation/.env.local
`
cat /root/formation/.env.local | grep SPRING_APPLICATION_JSON | cut -d "=" -f2 | python -m json.tool
`{{execute}}

- On relance le tomcat avec ces variables d'environnement :

`
docker run -d \
  --name=tomcat-app \
  --env-file /root/formation/.env.local \
  -p 8080:8080 \
  app
`{{execute}}

