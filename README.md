# Presentation of docker

-- Accroche
A travers le temps, on nous a régulièrement promis le fameux "Si ça marche chez moi, ça marchera chez toi" (Build once, run anywhere): VirtualBox-likes, Puppet-likes... que de trahisons.
Aujourd'hui, Docker jouit d'un engouement phénoménal, certains reçoivent déjà des conteneurs de leurs partenaires alors que d'autres se méfient de ses promesses. Mais qu'est-ce que Docker, vraiment?

Je ferai un brin de théorie avant de décortiquer 5 utilisations pratiques de cet outil, enfin on choisira quelques cas réels dans l'audience. Le but est de vous faire comprendre à quoi sert Docker et comment/quand l'utiliser.

## Théorie (10 min)

La virtualisation de machines a commencé très tôt, en 1967, avec le CP-40 d'IBM. Le système d'exploitation tournait dans une VM au dessus d'un programme de contrôle qui gérait les ressources.
Historiquement, c'était pratique pour partager les machines entre utilisateurs, on appelle cela le 'time-sharing'.
L'idée à fait son chemin et aujourd'hui nos machines sont tellement puissantes que faire tourner plusieurs OS est à la portée de tous, on pense par exemple à VirtualBox, VMWare ou encore Xen.
Ces machines virtuelles ont d'autres avantages, comme la sécurité: un processus, comme Firefox, qui tournerait dans une VM, est limité en RAM et CPU par des paramètres prédéfinis. Un utilisateur malveillant ou piraté lui-même n'a donc pas accès au système sous-jacent, et ne peut ainsi pas en prendre le contrôle ni lire ses données. Cette fonctionnalité peut être pratique pour les hébergeurs mutualisés par exemple.
Xen, quand à lui, est utilisé par Amazon pour EC2.. la liste est longue.

Mais cette technologie a un gros défaut: prévoir à l'avance la quantité de ressources allouées à une VM inclut d'empécher de se servir de toute la puissance de la machine. En effet si j'alloue 2 coeurs et 2Go de RAM, ces ressources sont perdues pour l'hôte, qu'elles soient utilisées ou non par la VM. Cet effet négatif peut être mitigé, via des scripts d'automatisation, mais la procédure est plus complexe et ne propose pas de vraie solution long terme.
De plus, une VM doit contenir un système d'exploitation. Par exemple si j'utilise Windows dans ma VM et que l'hôte est un Windows aussi, j'ai 2 Windows complets qui tournent.

C'est là que docker frappe, plutôt que d'allouer des ressources à l'avance, docker fait tourner des conteneurs dans un processus. Les conteneurs sont toujours basés sur Linux, et vous y ajoutez uniquement ce dont votre application a besoin.
Exemple: je créée un nouveau conteneur basé sur Ubuntu, j'installe Mumble et je dis à docker de faire tourner le tout.
Dans cet exemple, un seul Linux tourne, le deuxième (dans le conteneur) réutilise l'hôte en partageant le noyau. Le conteneur ne requiert que la RAM et le CPU dont il a besoin, et scale jusqu'au limites de la machine.
Côté points négatifs, Docker ne propose pas d'interface graphique pour les conteneurs, et est à l'heure actuelle moins sécurisé qu'une VM classique (mais ils bossent dessus). Pour des pros en sécurité il existe des solutions notemment à base de SELinux.

Pour permettre aux conteneurs d'interagir avec l'hôte, docker propose 3 méchanismes:
- partage de dossiers: par exemple je peux partager /home/baboon/docker/mumble
- don d'un port de l'hôte au conteneur: par exemple je peux rediriger le port 15680 de l'hôte vers le port 80 du conteneur (et donc exposer des services)
- pont réseau: les conteneurs ont accès aux mêmes réseaux que l'hôte par défaut (configurable)

De plus, docker offre la possibilité aux conteneurs de dialoguer entre eux. C'est pratique par exemple pour lier un Redis et un Postgres à un Gitlab qui utilise les deux.

Enfin, les conteneurs disposent d'un hub global (https://registry.hub.docker.com/) qui permet aux gens de partager les conteneurs qu'ils ont créé. Certains conteneurs sont "officiels" et donc fiables, mais méfiez vous des conteneurs de gens que vous ne connaissez pas en prod, pour des raisons de sécurité évidentes. Niveau entreprise, vous pouvez soit acheter des emplacements de conteneurs privés, soit installer un hub privé (https://github.com/docker/docker-registry).


## Installation (2-5min)

Infos générales:
-> https://docs.docker.com/installation

-----------

Installer sous Ubuntu:

1) `curl -sSL https://get.docker.io/ubuntu/ | sudo sh`
2) `sudo gpasswd -a ${USER} docker`
3) `sudo service docker restart`
4) logout, login

----------

Installer sous Windows/Mac:

Utiliser Boot2Docker, qui va créer une VM légère qui contient un linux basique avec juste ce qu'il faut pour faire tourner docker.
Il faudra faire attention quand vous voulez partager des dossiers entre l'hôte et un conteneur, cela ne fonctionne pas sans les "VirtualBox Guest Additions".
Voir  https://docs.docker.com/installation/windows ou https://docs.docker.com/installation/mac

-----------

## Utiliser docker comme.. (10 min each)

### ANY ~ Un exécutable
- sass: https://registry.hub.docker.com/u/saulshanabrook/sass/

### PROD ~ Une application sandboxée accessible via navigateur (style transmission)
- data-agnostic, je passe mon fichier Dockerfile à un pote et il a un son transmission aussi
- backup facile: Dockerfile + dossier "data"

### CLIENTS ~ Un conteneur qui contient tout, même les données de test
- réutilisable à l'infini puisqu'à chaque fois qu'on démarre le conteneur il est neuf
- le client n'a rien à installer si ce n'est docker
- le client n'a pas besoin de comprendre la techno -> effet boite noire

### DEV ~ Un environnement de travail agnostic
- container linux avec tout le toutim pour une appli ruby on rails (qui prend des plombes à installer correctement, x N avec N le nombre de développeurs)
- n'importe qui sous windows/mac/linux développe avec git+[son éditeur de texte favori]
- le conteneur fait tourner le code comme en prod

### SCENARIO COMPLEXE ~ Gitlab
- redis + postgres + gitlab + env

### SCENARO SECU
- préparer un conteneur sur une machine de dev et la passer sur une machine de prod sans accès internet

## Questions générales
