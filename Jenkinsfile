pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock -u root'  // Run as root user
        }
    }
    environment {
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_REPO = 'hagert/node-app'
        DOCKER_IMAGE_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Hager706/Docker-Build-Pipeline.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_REPO}:${DOCKER_IMAGE_TAG}", ".")
                }
            }
        }
        stage('Tag Docker Image') {
            steps {
                script {
                    dockerImage.tag("${DOCKER_REGISTRY}/${DOCKER_REPO}:${DOCKER_IMAGE_TAG}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_HUB_USER', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                     sh 'echo $DOCKER_HUB_PASSWORD | docker login -u $DOCKER_HUB_USER --password-stdin'
}
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Docker image built, tagged, and pushed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
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
//   --network jenkins \
//   -v /var/run/docker.sock:/var/run/docker.sock \
//   -e JENKINS_URL=http://jenkins:8080\
//   -e JENKINS_SECRET=f07f90a1a217b0da15c5f0cf3b91d1047243652ec8ba1459bb481411fa3974c9 \
//   -e JENKINS_AGENT_NAME=docker-agent \
//   jenkins/agent:latest
//   -webSocket
//  git push origin main   
//  git commit -m "finishing" 
//  git add .    

