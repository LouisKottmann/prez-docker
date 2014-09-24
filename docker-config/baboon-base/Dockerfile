# baboon:base
# latest tag can be found at: https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# (Ubuntu server 14.04)
FROM phusion/baseimage:0.9.12

# Get an up-to-date Ubuntu
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Common packages for all my images
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
                                   build-essential curl git openssl ca-certificates \
			           wget python python-dev python-software-properties g++ make

# set French timezone
RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
    echo "Europe/Paris" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# Allow SSH for me
ADD id_rsa.pub /tmp/louis_rsa.pub
RUN cat /tmp/louis_rsa.pub >> /root/.ssh/authorized_keys && rm -f /tmp/louis_pub.rsa

# Have a user that can't sudo to store files etc
RUN useradd -c "Useless user" -U -m monkey && \
    mkdir -vp /home/monkey/stuff && \
    chown -R monkey:monkey /home/monkey/stuff && \
    echo "DenyUsers monkey" >> /etc/ssh/sshd_config
