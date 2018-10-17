#Dockerfile for Spark Web App
FROM openjdk:8-jdk
MAINTAINER Instrutor <email@embrapa.br>
#Cria usuario sparkwebapp
RUN useradd -m sparkwebapp && echo "sparkwebapp:sparkwebapp" | chpasswd && adduser sparkwebapp sudo
#Seta proxies para build da imagem
ENV http_proxy 'http://proxy.cnptia.embrapa.br:3128'
ENV https_proxy 'http://proxy.cnptia.embrapa.br:3128'
ENV no_proxy 'localhost,127.0.0.1,.cnptia.embrapa.br,10.129.0.0/19'
USER sparkwebapp
ENV HOME /home/sparkwebapp
RUN chown sparkwebapp:sparkwebapp -R /home/sparkwebapp
#Copia arquivos java 
COPY ./lib /home/sparkwebapp/lib
COPY ./sparkwebapp.jar /home/sparkwebapp/sparkwebapp.jar
WORKDIR /home/sparkwebapp
ENTRYPOINT ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java", "-jar", "/home/sparkwebapp/sparkwebapp.jar"]
