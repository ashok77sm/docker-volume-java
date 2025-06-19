pipeline {
    agent {
        label 'docker-agent'
    }
    environment {
        DOCKER_IMAGE = 'ashokm77/test-repo'
        DOCKER_CREDENTIAL_ID = 'docker-creds'
    }
    stages {
        stage('checkout-stage') {
            steps {
                git branch: 'master', credentialsId: 'ashoksm', url: 'https://github.com/ashok77sm/docker-volume-java.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:V${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Deploy Container on Agent with Volume') {
            steps {
                script {
                    sh "docker volume create docker-volume"
                    sh "docker stop ${DOCKER_IMAGE}:V${env.BUILD_NUMBER} || true"
                    sh "docker rm ${DOCKER_IMAGE}:V${env.BUILD_NUMBER} || true"

                    docker.image("${DOCKER_IMAGE}:V${env.BUILD_NUMBER}").run("-p 9000:8080 -v docker-volume:/app -d")

                    echo "Waiting for container to start..."
                    sh "docker ps | grep ${DOCKER_IMAGE}:V${env.BUILD_NUMBER}"
                    echo "Application deployed and accessible on Docker Agent's public IP on port 9000."
                }
            }
        }
    }
}
