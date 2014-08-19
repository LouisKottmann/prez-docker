# Presentation of docker

-- Accroche
A travers le temps, on nous a régulièrement promis le fameux "Si ça marche chez moi, ça marchera chez toi" (Build once, run anywhere): VirtualBox-likes, Puppet-likes... que de trahisons.
Aujourd'hui, Docker jouit d'un engouement phénoménal, certains reçoivent déjà des conteneurs de leurs partenaires alors que d'autres se méfient de ses promesses. Mais qu'est-ce que Docker, vraiment?

Je ferai un brin de théorie avant de décortiquer 5 utilisations pratiques de cet outil, enfin on choisira quelques cas réels dans l'audience. Le but est de vous faire comprendre à quoi sert Docker et comment/quand l'utiliser.

## Theory (10 min)

Install:

- `sudo gpasswd -a ${USER} docker`
- `sudo service docker restart`


LXC, AUFS, Git-like...
boot2docker...
docker hub...

## Utiliser docker comme.. (10 min each)

### CLIENTS ~ Un conteneur qui contient tout, même les données de test
- réutilisable à l'infini puisqu'à chaque fois qu'on démarre le conteneur il est neuf
- le client n'a rien à installer si ce n'est docker
- le client n'a pas besoin de comprendre la techno -> effet boite noire
### PROD ~ Une application sandboxée accessible via navigateur (style transmission)
- data-agnostic, je passe mon fichier Dockerfile à un pote et il a un son transmission aussi
- backup facile: Dockerfile + dossier "data"
### ANY ~ Un exécutable (comme l'exécutable ruby que j'avais vu)
- shellcheck: installer haskell avec cabal ca prend normalement un temps de OUF
- sass: https://registry.hub.docker.com/u/saulshanabrook/sass/
### DEV ~ Un environnement de travail agnostic
- container linux avec tout le toutim pour une appli ruby on rails (qui prend des plombes à installer correctement, x N avec N le nombre de développeurs)
- n'importe qui sous windows/mac/linux développe avec git+[son éditeur de texte favori]
- le conteneur fait tourner le code comme en prod
### SCENARIO COMPLEXE ~ Gitlab
- redis + postgres + gitlab + env

## General questions
