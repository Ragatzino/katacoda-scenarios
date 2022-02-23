Le principe du docker compose est de concentrer toute la configuration d'applications nécessitant plusieurs container.


## Reprenons tout ce qui etait précedemment fait dans un seul fichier

Docker compose fonctionne avec un fichier de configuration general : le docker-compose.yml

> Nous abordons ce concept, il permet principalement de visualiser certains concepts avant de passer a Kubernetes

Il definit plusieurs concepts et permet une installation et desinstallation tres simplifiee d'une application:

- `services` : Chaque sous module avec image docker
- `network` : Definit le reseau partagé par les conteneurs
- `volumes` : Les volumes du deploiement

Cela donne un fichier de la sorte docker-compose.yml:

```yaml
version: '3.8'
services:
  appli:
    build: .
    image: app
    container_name: app
    ports:
      - 8080:8080
    environment:
        - SPRING_APPLICATION_JSON={"spring":{"h2":{"console":{"enabled":"false"}},"datasource":{"url":"jdbc:postgresql://postgres-app:5432/postgres","driverClassName":"org.postgresql.Driver","username":"postgres","password":"mdp"}},"jpa":{"defer-datasource-initialization":"false","database-platform":"org.hibernate.dialect.PostgreSQLDialect"}}
    restart: on-failure
    depends_on:
      - postgresql
    networks:
      - reseau-partage

  postgresql:
    image: postgres:11
    container_name: postgresql-db
    ports:
      - 5432:5432
    volumes:
      - pg_data:/var/lib/postgresql
      - init_db:/docker-entrypoint-initdb.d
    environment:
      - POSTGRES_USER=postgres 
      - POSTGRES_DB=postgres 
      - POSTGRES_PASSWORD=mdp 
      - PGDATA=/var/lib/postgresql/data/pgdata 
    restart: always
    networks:
      - reseau-partage

volumes:
  pg_data:
  init_db:/root/postgres/

networks:
  reseau-partage:
```{{copy}}

> Remarques : on a ici plusieurs choses en plus 

`depends_on` :  Attend que le postgres demarre pour se lancer
`restart` : Permet de preparer le cycle de vie de l'appli