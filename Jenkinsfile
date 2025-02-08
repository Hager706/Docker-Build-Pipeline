
pipeline {
    agent {
        docker {
            image 'docker:latest' // Use Docker-in-Docker image
            args '-v /var/run/docker.sock:/var/run/docker.sock'
            label 'docker-agent' // Ensure this label matches your Jenkins agent configuration
        }
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
// docker run -d \                                     
//   --name jenkins-agent \
//   --network jenkins \
//   -v /var/run/docker.sock:/var/run/docker.sock \
//   jenkins/inbound-agent:latest \
//   -url http://jenkins:8080 \
//   -secret f07f90a1a217b0da15c5f0cf3b91d1047243652ec8ba1459bb481411fa3974c9 \
//   -name docker-agent \
//   -webSocket
//docker stop jenkins-agent && docker rm jenkins-agent
// docker run -d \
//   --name jenkins-agent \
//   -v /var/run/docker.sock:/var/run/docker.sock \
//   -e JENKINS_URL=http://jenkins:8080\
//   -e JENKINS_SECRET=f07f90a1a217b0da15c5f0cf3b91d1047243652ec8ba1459bb481411fa3974c9 \
//   -e JENKINS_AGENT_NAME=docker-agent \
//   jenkins/agent:latest
//   -webSocket
//  git push origin main   
//  git commit -m "finishing" 
//  git add .    
