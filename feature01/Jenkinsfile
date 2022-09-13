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