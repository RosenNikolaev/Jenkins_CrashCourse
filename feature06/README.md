
# Docker  
### Prerequisites
- Have [docker](https://docs.docker.com/engine/install/) installed on your system
- Have [docker-compose](https://docs.docker.com/compose/install/) installed on your system 
---
## IP Basics
<img src=./Image2.png>
<br>

### Additional resources: 
- [IP basics](https://www.youtube.com/watch?v=LIzTo6e4FgY)
- [Subnet mask cheat sheet](https://dnsmadeeasy.com/support/subnet) 

## Docker Networks
<br>
<img src=./Image1.png>

### Additional resources: 
- [Docker Networks Overview](https://docs.docker.com/network/)

## Docker-Compose 
- Simplifies the creation of containers with attached networks, volumes, names ... 
- Enables the creation of more than one container with a single command ```docker-compose up``` 

Insead of running ```docker run -d -p 81:8080 -v jenkins-volume:/var/jenkins_home jenkins/jenkins``` for each and every container, all of the commands can be defined in a single yaml file.
```
version: '3.8'
# Docker containers
services:
  react-app:
    image: web-app
    environment:
      - _JAVA_OPTIONS=-Xmx512m -Xms256m
      - SPRING_PROFILES_ACTIVE=prod,api-docs
    ports:
      - 8013:8080
    depends_on:
      - postgresql
      - elasticsearch
    networks:
      - network-one

  postgresql:
    image: postgres:latest
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    ports:
      - 8014:5432
    networks:
      - network-one
  
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.9.3
    ports:
      - 8015:9200
      - 8016:9300
    environment:
      - 'ES_JAVA_OPTS=-Xms1024m -Xmx1024m'
      - 'discovery.type=single-node'
    networks:
      - network-one

# Network definition
networks:
  network-one:
   name: network-one-net
```
### Additional resources 
- [Docker-Compose](https://docs.docker.com/compose/)
# Cleanup
## Containers 
-  You can take a look at all running containers using ```docker ps``` 
-  You can stop a running container that you no longer want to use by running ```docker stop <CONTAINER_ID>```
  - You can also use the container `NAMES` instead of the ```<CONTAINER_ID>``` to specify which container to stop
  - If ```docker stop <CONTAINER_ID>``` does not work try using the ```docker kill <CONTAINER_ID>``` command, see [differences](https://www.baeldung.com/ops/docker-stop-vs-kill) 
-  You can take a look at all (running and stopped) containers with ```docker ps -a``` 
-  To clean up all stopped containers from using disk space on your machine use ```docker container prune```, [for further options](https://docs.docker.com/engine/reference/commandline/container_prune/)
## Images
-  You can list all docker images currently on your machine by running ```docker image ls```
-  You can remove a particular image by running ```docker image rm <REPOSITORY:TAG>```
-  You can remove [dangling images](https://docs.docker.com/config/pruning/) by running ```docker image prune```
-  You can remove ALL images by running ```docker image prune -a```
## Networks
- You can list all docker images currently on your machine by running ```docker network ls```
- You can remove a particular image by running ```docker network rm <NETWORK_NAME> ```
- You can remove all unused networks by running ```docker network prune```