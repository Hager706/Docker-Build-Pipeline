pipeline {
    agent {
        docker {
            image 'docker:latest'  
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock' 
        }
    }
    
    environment {
        DOCKERHUB_USER = credentials('docker')  
        IMAGE_NAME = 'hagert/node-app'
        IMAGE_TAG = 'latest'
        GIT_REPO = 'https://github.com/Hager706/Docker-Build-Pipeline.git'
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                script {
                    git branch: 'main', url: env.GIT_REPO
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_USER_PSW | docker login -u $DOCKERHUB_USER_USR --password-stdin'
            }
        }
        
        stage('Push Image to Docker Hub') {
            steps {
                sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
            }
        }
        
        stage('Cleanup') {
            steps {
                sh 'docker rmi $IMAGE_NAME:$IMAGE_TAG || true'
            }
        }
    }
}
