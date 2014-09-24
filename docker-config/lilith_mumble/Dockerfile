FROM ubuntu:14.04

# Upgrade the build and include the universe repo.
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Install the mumble dependencies
RUN apt-get install -y libterm-readline-perl-perl
RUN apt-get install -y openssh-server mumble-server sudo
RUN mkdir -p /var/run/sshd

# Install supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
RUN locale-gen en_US en_US.UTF-8
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN useradd -m -p admin -r -s /bin/bash -g root admin
RUN echo "admin:admin" | chpasswd
RUN sudo adduser admin sudo

# Make the ports available for Mumble.
EXPOSE 64738

# give permissions
RUN mkdir -vp /data/database
RUN chown -R admin:root /data

# Server startup command
CMD ["/usr/bin/supervisord"]

# To set the initial superuser password to admin run with cmd:
# /usr/sbin/murmurd -fg -ini /etc/mumble-server.ini -supw superusepassword
