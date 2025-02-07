pipeline {
    agent {
        docker {
            image 'docker:24.0.7'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        DOCKER_IMAGE = "hagert/node-app"
        DOCKER_TAG = "latest"
        REGISTRY_CREDENTIALS = "docker-hub-credentials"
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Hager706/Docker-Build-Pipeline.git'
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
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
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
