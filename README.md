# Intro to Jenkins 
## Prerequisites 
-  Have [docker](https://docs.docker.com/engine/install/) installed on your system
- Have [docker-compose](https://docs.docker.com/compose/install/) installed on your system 
## Contents 
- Introduction ([feature00](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature00))
- Base Jenkins image deployment ([feature01](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature01))
- Simple Dockerfile Jenkins deployment  ([feature02](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature02))
- Extended Dockerfile Jenkins deployment  ([feature03](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature03)) 
- Simple Jenkinsfile overview  ([feature04](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature04)) 
- Extended Jenkinsfile  ([feature05](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature05))
- Docker Networks and Docker-Compose  ([feature06](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature06))
- Jenkins docker in docker configuration and the docker-workflow plugin ([feature07](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature07))


# Additional Resources 
Writing your own [Dockerfile](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) that fits your project needs

[![Nana Docker](https://img.youtube.com/vi/jPdIRX6q4jA/0.jpg)](https://www.youtube.com/watch?v=jPdIRX6q4jA&list=PLy7NrYWoggjzfAHlUusx2wuDwfCrmJYcs)

[![Nana Jenkins](https://img.youtube.com/vi/pMO26j2OUME/0.jpg)](www.youtube.com/watch?v=pMO26j2OUME&list=PLy7NrYWoggjw_LIiDK1LXdNN82uYuuuiC&index=1)

# Workspace Cleanup
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
## Volumes
-  If you want to remove the Jenkins data and configuration you can run ```docker volume rm <volume_name>``
-  If you want to remove all docker volumes run ```docker volume prune -a```
