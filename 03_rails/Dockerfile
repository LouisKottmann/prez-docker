FROM ubuntu:14.04

# Mettre à jour Ubuntu
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# Installer les outils dont on dépend
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget tar g++ make zlib1g-dev libssl-dev libyaml-dev

# Créer un dossier pour stocker les fichiers d'installation
RUN mkdir /setup
WORKDIR /setup

# Télécharger le dernier ruby
RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz

# Décompresser
RUN tar zxf ruby-2.1.3.tar.gz

# Installer ruby
RUN cd ruby-2.1.3 && \
    ./configure && \
    make && \
    make install

# Installer les dépendances de l'application rails
RUN  DEBIAN_FRONTEND=noninteractive apt-get -y install git sqlite3 libsqlite3-dev
RUN gem install bundler

RUN git clone https://github.com/erikthedeveloper/rails-todo-app-simple.git
WORKDIR rails-todo-app-simple
RUN bundle install
RUN rake db:setup

CMD rails server
