# Further automating setup through Dockerfile 

## Install Jenkins plugins during the build process
- Create a plugins.txt file in the local build directory as `plugin:version`

plugins.txt
```
ant:latest
antisamy-markup-formatter:latest
build-timeout:latest
cloudbees-folder:latest
configuration-as-code:latest
...
```
-  Copy the `plugins.txt` file during the build process and execute the ```jenkins-plugin-cli``` to install the plugins defined in it

Dockerfile 
```
COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
```
## Jenkins Configuration as Code [JCasC](https://github.com/jenkinsci/configuration-as-code-plugin/blob/master/README.md)
- Have access to jenkins only when authenticated 
casc.yaml
```  
authorizationStrategy: 
            projectMatrix:
            permissions:
                - "View/Delete:authenticated"
                - "View/Read:authenticated"
                - "View/Configure:authenticated"
                - "View/Create:authenticated"
                - "Job/Read:authenticated"
                - "Job/Build:authenticated"
                - "Job/Configure:authenticated"
                - "Job/Create:authenticated"
                - "Job/Delete:authenticated"
                - "Job/Discover:authenticated"
                - "Job/Move:authenticated"
                - "Job/Workspace:authenticated"
                - "Job/Cancel:authenticated"
                - "Run/Delete:authenticated"
                - "Run/Replay:authenticated"
                - "Run/Update:authenticated"
                - "SCM/Tag:authenticated"
                - "Overall/Administer:authenticated" 
                # - "Overall/Read:anonymous"
``` 
- Add a default usr and password with Dockerfile environment variables

casc.yaml
```
  securityRealm:
    local:
      allowsSignup: false 
      users:
       - id: ${JENKINS_ADMIN_USR}
         password: ${JENKINS_ADMIN_PASS} 
```
- Set the default jenkins url

casc.yml
```
unclassified:
  location:
    url: http://localhost:81/ 
```
- Make sure that the jenkins_home folder exists and copy the casc.yml inside of it

Dockerfile
```
RUN mkdir -p /var/jenkins_home/
COPY ./casc.yaml /var/jenkins_home/casc.yaml
```
- Set the location of the casc config

Dockerfile
```
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
```

# Workspace Cleanup
## Containers 
- [ ] You can take a look at all running containers using ```docker ps``` 
- [ ] You can stop a running container that you no longer want to use by running ```docker stop <CONTAINER_ID>```
  - You can also use the container `NAMES` instead of the ```<CONTAINER_ID>``` to specify which container to stop
  - If ```docker stop <CONTAINER_ID>``` does not work try using the ```docker kill <CONTAINER_ID>``` command, see [differences](https://www.baeldung.com/ops/docker-stop-vs-kill) 
- [ ] You can take a look at all (running and stopped) containers with ```docker ps -a``` 
- [ ] To clean up all stopped containers from using disk space on your machine use ```docker container prune```, [for further options](https://docs.docker.com/engine/reference/commandline/container_prune/)
## Images
- [ ] You can list all docker images currently on your machine by running ```docker image ls```
- [ ] You can remove a particular image by running ```docker image rm <REPOSITORY:TAG>```
- [ ] You can remove [dangling images](https://docs.docker.com/config/pruning/) by running ```docker image prune```
- [ ] You can remove ALL images by running ```docker image prune -a```
## Volumes
- [ ] If you want to remove the Jenkins data and configuration you can run ```docker volume rm <volume_name>``
- [ ] If you want to remove all docker volumes run ```docker volume prune -a```