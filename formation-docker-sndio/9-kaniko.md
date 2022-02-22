Si il n'est pas encore possible d'utiliser pleinement Docker sur les postes, il est déjà possible d'utiliser Docker dans des pipelines d'intégration continue.

## Présentation de Kaniko

Kaniko propose une solution permettant de packager des images sans droits élevés, en effet, la plupart des systèmes de types Kubernetes ou pipelines ne vous permettront pas d'utiliser des images aux droits élevés ou du moins restreindront leur usage.

L'idée derrière kaniko réside en la fabrication d'images au sein même d'un conteneur, et de l'exposition de l'image construite par un volume.

Exemple extrait de la documentation : 
`
docker run \
    -v "$HOME"/.config/gcloud:/root/.config/gcloud \
    -v /path/to/context:/workspace \
    gcr.io/kaniko-project/executor:latest \
    --dockerfile /workspace/Dockerfile \
    --destination "gcr.io/$PROJECT_ID/$IMAGE_NAME:$TAG" \
    --context dir:///workspace/
`

> Il faut donc renseigner : l'image a l'arrivée dans le registre ici (gcr.io/$PROJECT_ID/$IMAGE_NAME:$TAG) mais par exemple en interne: (https://harbor.developpement.insee.fr/)

## Qu'est ce que ca changerait en interne ?

**Creer des logins sur un registry interne :**

- Connectez vous a https://harbor.developpement.insee.fr/harbor/projects
- Creez un projet 
- Creer un compte robot (Sauvegardez les donnees)

**Creation d'un projet sur Gitlab :**

- Recreez un depot git a partir du depot de l'appli spring boot
- Ajouter votre Dockerfile construit au cours de la formation
- Et integrez l'appel a kaniko pour construire l'image dans un docker 
=> Exemple : https://gitlab.insee.fr/exemples-kube-orleans/image-docker

