pipeline {
    agent any
    stages {
        stage('Check which versions are installed on the node') {
            steps {
               echo "Java version is "
               sh "java --version"
               echo "Python version is"
               sh "python --version"
               echo "Node version is"
               sh "node -v"
               echo "Npm version is"
               sh "npm -v"
            }
        }
    }
}