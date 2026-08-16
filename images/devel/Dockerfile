FROM debian:trixie

## Update packages to install
RUN apt-get update

## install openssh so we can connect remotely
RUN apt-get install -y openssh-server

## we don't create a home directory, k8s init container will create the home directory
RUN useradd -M -s /bin/bash dev

## install sudo and sudoers file
RUN apt-get install -y sudo
RUN echo "dev ALL=(ALL) NOPASSWD:ALL\n" >/etc/sudoers.d/99-dev-user

## install packages and programs need to build and run app
## install extra programs
RUN apt-get install -y curl unzip git less gpg lsb-release

## install rust
RUN apt-get install -y rustup pkg-config libwayland-dev libasound2-dev libudev-dev
RUN rustup default stable

## install node and npm
RUN apt-get install -y nodejs npm

## install maven
RUN apt-get install -y maven

## install java package
RUN curl -L https://apt.corretto.aws/corretto.key | gpg --dearmor -o /usr/share/keyrings/corretto-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list
RUN apt-get update
RUN apt-get install -y java-25-amazon-corretto-jdk

## install aws cli package
RUN curl -L -O "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install

## install terraform package
RUN curl -L https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update
RUN apt-get install terraform

## install database clients
RUN apt-get install -y mariadb-client postgresql-client redis-tools

RUN curl -fsSL https://pgp.mongodb.com/server-8.0.asc | gpg  --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg
RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/debian trixie/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
RUN apt-get update
RUN apt-get install -y mongodb-mongosh

## install tools
RUN apt install -y vim bind9-host iproute2

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
