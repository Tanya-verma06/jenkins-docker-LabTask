pipeline {

```
agent any

environment {
    IMAGE_NAME = "tanya-verma06/jenkins-demo"
    CONTAINER_NAME = "my-website"
}

stages {

    // Stage 1: Pull Code from GitHub
    stage('Git Checkout') {
        steps {
            echo 'Pulling code from GitHub'

            checkout scm
        }
    }

    // Stage 2: Build Docker Image
    stage('Docker Build') {
        steps {
            echo 'Reading Dockerfile and building image'

            sh '''
                docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest
            '''
        }
    }

    // Stage 3: Login to Docker Hub
    stage('Docker Login') {
        steps {

            withCredentials([
                usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )
            ]) {

                sh '''
                    echo "$DOCKER_PASS" | docker login \
                    -u "$DOCKER_USER" \
                    --password-stdin
                '''
            }
        }
    }

    // Stage 4: Push Image to Docker Hub
    stage('Docker Push') {
        steps {

            echo 'Pushing Docker Image to Docker Hub'

            sh '''
                docker push ${IMAGE_NAME}:${BUILD_NUMBER}
                docker push ${IMAGE_NAME}:latest
            '''
        }
    }

    // Stage 5: Deploy Container
    stage('Deploy Application') {
        steps {

            echo 'Deploying Application on Port 83'

            sh '''
                docker rm -f ${CONTAINER_NAME} || true

                docker run -d \
                --name ${CONTAINER_NAME} \
                -p 83:80 \
                --restart unless-stopped \
                ${IMAGE_NAME}:latest
            '''
        }
    }
}

post {

    success {
        echo 'Application Deployed Successfully!'
        echo 'Open: http://localhost:83'
    }

    failure {
        echo 'Pipeline Failed! Check Console Output.'
    }
}
```

}
