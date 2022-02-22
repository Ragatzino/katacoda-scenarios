A des fins de testing, vous pourriez être amené a vouloir travailler avec un PostgreSQL en local, ou dans des pipelines par exemple.

(Nous avons maintenant psql d'installé sur l'environnement)

## Lancement d'un postgre
L'installation d'une base postgres sur un environnement via docker se fait en utilisant l'image officielle postgres : https://hub.docker.com/_/postgres

> Pour cette image, on doit valoriser la variable **POSTGRES_PASSWORD**, et l'on peut par ailleurs valoriser d'autres variables e.g. **POSTGRES_USER**,**POSTGRES_DB**

Lançons par exemple une instance de postgres 11 : 

`
docker run -d \
  --name postgres-base \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_PASSWORD=mdp \
  -p 5432:5432 \
  --name postgres postgres:11
`{{execute}}

Vous pouvez y accéder directement:

`
psql -h localhost -p 5432  -U postgres -c 'SELECT 1;'
`{{execute}}

ou depuis l'intérieur du conteneur:

`
docker exec postgres-base psql -U postgres -c 'SELECT 1;'
`{{execute}}

Postgres utilise par défaut des volumes, constatez par vous même : 
`
docker volume ls
`{{execute}}

## Initialisation d'un volume

Par défaut postgresql attend des données sur **/var/lib/postgresql/data** (on peut changer cela via la variable d'environnement **PGDATA**).

A chaque fois que vous utilisez une image qui nécessite un volume, il est préconisé de préciser l'espace utilisé, afin de ne pas le dupliquer autant de fois que l'image tourne.

Créons un espace dedie :

`
mkdir /root/pg_data/
`{{execute}}

Cela se fait par l'option **-v** de docker run :

`
docker run -d \
  --name=postgres-avec-volume \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_PASSWORD=mdp \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v /root/pg_data/:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:11 
`{{execute}}

## Script au démarrage de la base de données

Postgres précise dans son image :
(Rubrique Initialization scripts [ici](https://hub.docker.com/_/postgres/) )
qu'il utilise un dossier : /docker-entrypoint-initdb.d/ et execute tous les scripts sql disponibles a cet endroit au démarrage du postgres.

Un script d'initialisation de base de données a été chargé sur /root/postgres

`
tree -L 2 /root/
`{{execute}}

**Voir le script**: `
cat /root/postgres/initdb.sql
`{{execute}}

Utilisez les volumes pour lancer une base de données avec les scripts disponibles dans **/root/postgres/**

<details>
<summary>Solution (cliquer pour avoir la réponse)</summary>
    <p>

`
docker run -d \
  --name=postgres-avec-init \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_PASSWORD=mdp \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v /root/postgres/:/docker-entrypoint-initdb.d/ \
  -p 5433:5432 \
  postgres:11 
`{{execute}}

<br/>

**Verifications :***

`
  psql -h localhost -p 5433  -U postgres -c 'SELECT * from utilisateur;'
`{{execute}}

</p>
</details>