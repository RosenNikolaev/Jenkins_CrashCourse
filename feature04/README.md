# Writing your first Jenkinsfile
- What is Groovy, [differences with Java](https://groovy-lang.org/differences.html) 
  - Two types of Jenkinsfile syntax [Declerative vs Scripted](https://dsstream.com/declarative-vs-scripted-pipeline-key-differences/)
- [Declerative Syntax](https://docs.cloudbees.com/docs/admin-resources/latest/pipeline-syntax-reference-guide/declarative-pipeline)
```
pipeline {
    agent any
    stages {

        stage('Check repository contents') {
            steps {
                echo "Which user are we using"
                sh "whoami"
                echo "Check absolute path"
                sh "pwd"
                echo "List all files in workspace"
                sh "ls -la"
            }
        }

        stage('Check which versions are installed on the node') {
            steps {
               echo "Java version is: "
               sh "java --version"
               echo "Maven version is:"
               sh "mvn --version"
               echo "Python version is:"
               sh "python3 --version"
            }
        }

    }   
}
```
- [Scripted Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/#scripted-pipeline)
```
node {
    stage('Example') {
        try {
            sh 'exit 1'
        }
        catch (exc) {
            echo 'Something failed, I should sound the klaxons!'
            throw
        }
    }
}
```
- [Script Block inside of a Declarative Pipeline](https://www.jenkins.io/doc/book/pipeline/syntax/#script)
```
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'

                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo "Testing the ${browsers[i]} browser"
                    }
                }
            }
        }
    }
}
```
# Workspace Cleanup
## Containers 
- You can take a look at all running containers using ```docker ps``` 
- You can stop a running container that you no longer want to use by running ```docker stop <CONTAINER_ID>```
  - You can also use the container `NAMES` instead of the ```<CONTAINER_ID>``` to specify which container to stop
  - If ```docker stop <CONTAINER_ID>``` does not work try using the ```docker kill <CONTAINER_ID>``` command, see [differences](https://www.baeldung.com/ops/docker-stop-vs-kill) 
- You can take a look at all (running and stopped) containers with ```docker ps -a``` 
- To clean up all stopped containers from using disk space on your machine use ```docker container prune```, [for further options](https://docs.docker.com/engine/reference/commandline/container_prune/)
## Images
- You can list all docker images currently on your machine by running ```docker image ls```
- You can remove a particular image by running ```docker image rm <REPOSITORY:TAG>```
- You can remove [dangling images](https://docs.docker.com/config/pruning/) by running ```docker image prune```
- You can remove ALL images by running ```docker image prune -a```
## Volumes
- If you want to remove the Jenkins data and configuration you can run ```docker volume rm <volume_name>``
- If you want to remove all docker volumes run ```docker volume prune -a```
