
pipeline {
    agent { label 'docker' }  
    environment {
        IMAGE_NAME = "hagert/app"
        TAG = "latest"
        DOCKER_CREDENTIALS_ID = "docker"
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Hager706/Docker-Build-Pipeline.git', branch: 'main'
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }
        stage('Push Image') {
            steps {
                sh 'docker push $IMAGE_NAME:$TAG'
            }
        }
    }
}
