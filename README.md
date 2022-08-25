# How to install and setup Jenkins on Docker 
- [ ] Doing so without any specific configuration
  - Running the ```docker pull jenkins/jenkins:<latest jenkins lts release>``` to pull the image from dockerhub from [DockerHub](https://hub.docker.com/r/jenkins/jenkins)
  - Running the ```docker run -p 8080:8080 jenkins/jenkins:<jenkins tag from the docker pull command>```
- [ ] By using the Dockerfile supplied in this repository and editing the configuration
- [ ] By writing your own [Dockerfile](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) that fits your project needs
## Using and configuring the Dockerfile in this repository
- [ ] By running ```docker build -t <yourdockerhub username>/jenkins .```
- [ ] By running ```docker run -p 80:8080 <yourdockerhub username>/jenkins```
  - You can substitute port 80 in the ```-p 80:8080``` part of the command with any port you want your jenkins to run on
## 
