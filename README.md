# Intro to Jenkins 
### Prerequisites 
-  Have [docker](https://docs.docker.com/engine/install/) installed on your system
## Using Jenkins without any specific configuration
-  Run ```docker pull jenkins/jenkins:<latest jenkins lts release>``` to pull the image from [DockerHub](https://hub.docker.com/r/jenkins/jenkins)
-  Run ```docker volume create <volume_name>``` to create a [volume](https://docs.docker.com/storage/volumes/) so that if/when the conainer is stopped your data in jenkins persists
-  Run ```docker run -d -p 80:8080 -v <volume_name>:/var/jenkins_home --name jenkins-docker jenkins/jenkins:<latest jenkins lts release>```
  - You can substitute port 80 in the ```-p 80:8080``` part of the command with any port you want your jenkins to run on
-  Go to ```http://localhost:80```and wait for Jenkins to load
  - If prompted for an initial admin password run ```docker exec -it jenkins-docker cat /var/jenkins_home/secrets/initialAdminPassword``` in your terminal and paste the output back in the browser
## Using Jenkins by further configuring one of the [Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) supplied in this repository
-  Navigate to one of the features
-  Run ```docker build -t <yourdockerhub username>/jenkins .```
-  Run ```docker volume create <volume_name>```
-  By running ```docker run -d -p 80:8080 -v <volume_name>:/var/jenkins_home <yourdockerhub username>/jenkins```
  - You can substitute port 80 in the ```-p 80:8080``` part of the command with any port you want your jenkins to run on
-  Go to ```http://localhost:80```and wait for Jenkins to load
  - If prompted for an initial admin password run ```docker exec -it jenkins-docker cat /var/jenkins_home/secrets/initialAdminPassword``` in your terminal and paste the output back in the browser
## Writing your own [Dockerfile](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) that fits your project needs
-  [Docker in Docker](https://www.jenkins.io/doc/book/installing/docker/) configuration and how to set it up
  - Usefull if you need more than one node in jenkins
# JenkinsFiles
-  What is Groovy, [differences with Java](https://groovy-lang.org/differences.html) 
  - Two types of Jenkinsfile syntax [Declerative vs Scripted](https://dsstream.com/declarative-vs-scripted-pipeline-key-differences/)
-  [Declerative Syntax](https://docs.cloudbees.com/docs/admin-resources/latest/pipeline-syntax-reference-guide/declarative-pipeline)
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

# Additional Resources 
[![Nana Docker](https://img.youtube.com/vi/jPdIRX6q4jA/0.jpg)](https://www.youtube.com/watch?v=jPdIRX6q4jA&list=PLy7NrYWoggjzfAHlUusx2wuDwfCrmJYcs)

[![Nana Jenkins](https://img.youtube.com/vi/pMO26j2OUME/0.jpg)](www.youtube.com/watch?v=pMO26j2OUME&list=PLy7NrYWoggjw_LIiDK1LXdNN82uYuuuiC&index=1)
