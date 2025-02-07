pipeline {
    agent {
        label 'docker-agent' 
    }
    environment {
        DOCKER_IMAGE = "hagert/node-app"
        DOCKER_TAG = "latest"
        REGISTRY_CREDENTIALS = "dockerhub"
        GIT_CREDENTIALS = "github"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    credentialsId: GIT_CREDENTIALS, 
                    url: 'https://github.com/Hager706/Docker-Build-Pipeline.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: REGISTRY_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                }
            }
        }
        stage('Push Image to Docker Hub') {
            steps {
                sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
            }
        }
    }
}
