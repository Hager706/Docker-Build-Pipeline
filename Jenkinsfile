pipeline {
    agent {
        docker {
            image 'docker:latest'  // Use the Docker CLI image
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'  // Mount Docker socket
        }
    }

    environment {
        IMAGE_NAME = 'hagert/node-app'  // Docker image name
        IMAGE_TAG = 'latest'            // Docker image tag
        GIT_REPO = 'https://github.com/Hager706/Docker-Build-Pipeline.git'  // Git repository URL
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: env.GIT_REPO]]])
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Login to Docker Hub') {
            environment {
                DOCKER_CREDENTIALS = credentials('docker-hub')  // Use Jenkins credentials for Docker Hub
            }
            steps {
                sh '''
                    echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin
                '''
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Cleanup') {
            steps {
                sh 'docker rmi $IMAGE_NAME:$IMAGE_TAG || true'  // Remove the image, ignore errors if it doesn't exist
            }
        }
    }

    post {
        always {
            cleanWs()  // Clean the workspace after the pipeline runs
        }
    }
}