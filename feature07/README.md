# Using Docker containers as runtime agents for your Jenkins pipeline
## Prerequisites 
-  Have [docker](https://docs.docker.com/engine/install/) installed on your system
## Configure the Dockerfile to install docker 
Add to your existing Dockerfile
``` 
## Install requirements for docker
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common

## Add the docker repository 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

## Install docker  
RUN apt-get update  -qq \
    && apt-get install docker-ce -y

## Add the jenkins user to the docker group 
RUN usermod -aG docker jenkins
```
## Add the docker pipeline plugin
Add a new line containing ```docker-workflow:latest``` to plugins.txt to automatically install the plugin during the docker build process.  
`You could also do this step through the GUI after starting the container` 

## Build the image 
```
docker build -t <docker-hub-usr>/jenkins-dind:latest . 
```

## Start a container from the image 
```
docker run -d -p 81:8080 -v <volume_name>:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock <docker-hub-usr>/jenkins-dind:latest
```
Where the ```-v /var/run/docker.sock:/var/run/docker.sock``` binds the docker socket on your own machine to the docker socket of the container
<img src=./Image1.png>
<br>

## Using docker as a build agent
### As an agent for the whole pipeline
```
pipeline {
    agent {
        docker { image 'node:16.13.1-alpine' }
    }
    stages {
        stage('Check node version') {
            steps {
                sh 'node --version'
            }
        }
    
        stage ('Next stage'){
            ...
        }
    }
}
```
You can specify an agent for all of the stages inside of the `pipeline` block
### As an agent for each stage
```
pipeline {
    agent none 
    stages {
        stage('BE') {
            agent {
                docker {image 'maven:3.8.6-openjdk-18'}
            }
            steps {
                sh 'mvn --version'
            }
        }
        stage('FE'){
            agent { 
                docker {image 'node:16.13.1-alpine'}
            }
            steps{
                sh 'node --version'
            }
        }
    }
}
```
You can specify different agents for each of the different stages inside of each individual `stage` block  

`Note that both use docker-hub as a default registry`
## Using a custom Dockerfile
You can also specify a custom Dockerfile, see [feature07-01](https://github.com/RosenNikolaev/Jenkins_CrashCourse/tree/master/feature07/feature07-1)

```
pipeline {
    agent none 
    stages {
        stage('Custom Dockerfile') {
            agent {
                dockerfile true 
            }
            steps {
               ...
            }
        }
        stage('Custom Dockerfile name'){
            agent {
                dockerfile {
                    filename 'DifferentDockerFilename'
                }
            }
            steps {
                ...
            }
        }
    }
}
```
## Additional Resources
- [Docker as agent](https://www.jenkins.io/doc/book/pipeline/docker/) 
   - Scripted usage
    - Custom repositories