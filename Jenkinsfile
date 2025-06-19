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

                    docker.image("${DOCKER_IMAGE}:V${env.BUILD_NUMBER}").run("-p 9000:8080 -v docker-volume:/app -d")
                }
            }
        }
    }
}
