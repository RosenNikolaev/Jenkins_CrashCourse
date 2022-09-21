# Jhipster and Jenkins
## Prerequisites 
-  Have [docker](https://docs.docker.com/engine/install/) installed on your system
-  Have [docker-compose](https://docs.docker.com/compose/install/) installed on your system 

## Build the Jenkins image 
```
docker build -t <docker-hub-usr>/jenkins-dind:latest . 
```

## Start the jenkins container
```
docker run -d -p 81:8080 -v <volume_name>:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock <docker-hub-usr>/jenkins-dind:latest
```

## Create credentials for the SCM (Github) and the Docker Image repository (Dockerhub)
Following the steps below create credentials for both Github and Dockerhub
` Note Github might require you to use a Personal Access Token instead of a password`  
- From the Jenkins Dashboard, go to `Manage Jenkins`
- `Manage Credentials`
- Under `Stores scoped to Jenkins`, click on `Jenkins`
- Click on `Global Credentials`
- On the left part of the screen click on ` + Add Credentials` 
- Enter your username and password, and set an ID (E.G. mycreds-github; mycreds-dockerhub) for the credential 
` Note this ID is important for accessing the credential inside of the pipeline` 

## Create a pipeline for your project and connect it to the Github repository
- From the Jenkins Dashboard click on new item 
- Write a name for your pipeline and select the Pipeline option, click on OK
- Scroll down to pipeline
    - Change the Definiton from `Pipeline Script` to `Pipeline Script from SCM` 
    - Select GIT as your SCM
    - Enter your repository URL
    - Select the github credentials that you entered in the previous step, or you can add them from here
    - Select a branch different from master if you need to
    - Specify the path to the Jenkinsfile, which you want to use, for this feature it is ```feature08/jhipster/Jenkinsfile```
- Click on Apply and then Save to save the changes

## Create a repository in your dockerhub account to be able to push the image
If your image name is ```<your-dockerhub-username>/jhipster:latest```, the repository you create in Dockerhub should be called `jhipster`

## Configure the Jenkinsfile
- Go to /feature08/jhipster/
- Open the Jenkinsfile
    -  Change the ```credentialsId: ''``` in the line ``` withCredentials([usernamePassword(credentialsId: "rnikolaev-dockerhub", usernameVariable: "REGISTRY_CREDS_USR", passwordVariable: "REGISTRY_CREDS_PSW")]) ``` string to the ID you set in your Jenkins Credentials for dockerhub
    -  Edit the command ``` cd ./feature08/jhipster/ && ./mvnw -Pprod clean package jib:build -Djib.to.auth.username=$REGISTRY_CREDS_USR -Djib.to.auth.password=$REGISTRY_CREDS_PSW -Dimage=registry.hub.docker.com/android2e/jhipster:latest -Djib.to.tags=$HEADHASH -DskipTests ```, where you change ```android2e/jhipster:latest ``` to your ```<your-dockerhub-username>/jhipster:latest```

## Commit and push your changes to the git repository you connected to your Jenkins

## You can now run your pipeline and if you set your credentials successfully it should build the image and it will be sent to your dockerhub repository with the two tags