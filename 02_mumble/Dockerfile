FROM ubuntu:14.04

# Mise à jour d'Ubuntu avec le repo universe
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Installer mumble et ses dépendances
RUN apt-get install -y libterm-readline-perl-perl
RUN apt-get install -y openssh-server mumble-server sudo
RUN mkdir -p /var/run/sshd

# Installer un superviseur (supervisor)
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
RUN locale-gen en_US en_US.UTF-8
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Ajouter un utilisateur qui fera tourner mumble
RUN useradd -m -p admin -r -s /bin/bash -g root admin
RUN echo "admin:admin" | chpasswd
RUN sudo adduser admin sudo

# Exposer le port pour que mumble puisse communiquer avec l'extérieur du conteneur
EXPOSE 64738

# Donner les permissions à l'utilisateur que nous avons défini
RUN mkdir -vp /data/database
RUN chown -R admin:root /data

# Commande par défaut (lancement du superviseur, qui va garder le serveur mumble up)
CMD ["/usr/bin/supervisord"]

# Vous pouvez mettre le mot de passe en faisant tourner le conteneur avec cette commande (ca va écraser CMD pour un tour)
# /usr/sbin/murmurd -fg -ini /etc/mumble-server.ini -supw superusepassword
