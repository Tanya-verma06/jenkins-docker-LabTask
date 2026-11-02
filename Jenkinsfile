pipeline {
    agent any

    environment {
        IMAGE_NAME = "tanya-verma06/jenkins-demo"
        CONTAINER_NAME = "my-website"
    }

    stages {

        stage('Git Checkout') {
            steps {
                echo 'Pulling code from GitHub'
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker Image'
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Docker Hub Push') {
            steps {
                echo 'Pushing image to Docker Hub'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}:latest
                        docker logout
                    '''
                }
            }
        }
    }
}