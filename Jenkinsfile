pipeline {
    agent { label 'node1' }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sharara99/spring-petclinic.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t sharara99/spring:${BUILD_NUMBER} ."

                    withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh "docker login -u \"$DOCKER_USER\" -p \"$DOCKER_PASS\""
                    }

                    sh "docker push sharara99/spring:${BUILD_NUMBER}"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for errors.'
        }
    }
}
