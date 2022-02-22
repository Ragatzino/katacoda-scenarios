Le principe du docker compose est de concentrer toute la configuration d'applications nécessitant plusieurs container.

## Reprenons tout ce qui etait precedemment fait dans un seul fichier

Docker compose fonctionne avec un fichier de configuration general : le docker-compose.yml

> Nous abordons ce concept, il permet principalement de visualiser certains concepts avant de passer a Kubernetes

Il definit plusieurs concepts et permet une installation et desinstallation tres simplifiee d'une application:

- Services : Chaque sous module avec image docker
- 