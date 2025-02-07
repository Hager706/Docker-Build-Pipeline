pipeline {
    agent {
        docker {
            image 'docker:latest'  
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        DOCKER_HUB_USER = credentials('docker')  
        IMAGE_NAME = 'hagert/app'
    }
    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Hager706/Docker-Build-Pipeline.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }
        stage('Tag Docker Image') {
            steps {
                sh 'docker tag $IMAGE_NAME $IMAGE_NAME:latest'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKER_HUB_USER_PSW | docker login -u $DOCKER_HUB_USER --password-stdin'
            }
        }
        stage('Push Image to Docker Hub') {
            steps {
                sh 'docker push $IMAGE_NAME:latest'
            }
        }
    }
}
