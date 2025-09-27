pipeline {
    agent any

    environment {
        FRONTEND_DIR = "frontend"
        BACKEND_DIR = "backend"
        FRONTEND_IMAGE = "justbook-frontend"
        BACKEND_IMAGE = "justbook-backend"
        REGISTRY = "your-registry.example.com/justbook"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Frontend Install') {
            steps {
                dir(FRONTEND_DIR) {
                    sh 'npm install'
                }
            }
        }

        stage('Frontend Test & Build') {
            steps {
                dir(FRONTEND_DIR) {
                    sh 'npm test -- --watch=false'
                    sh 'npm run build'
                }
            }
        }

        stage('Backend Build & Test') {
            steps {
                dir(BACKEND_DIR) {
                    sh 'mvn -B clean verify'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker build -t ${FRONTEND_IMAGE}:latest ${FRONTEND_DIR}'
                sh 'docker build -t ${BACKEND_IMAGE}:latest ${BACKEND_DIR}'
            }
        }

        stage('Publish Docker Images') {
            when {
                expression { return env.DOCKER_CREDENTIALS_ID }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin ${REGISTRY}'
                    sh 'docker tag ${FRONTEND_IMAGE}:latest ${REGISTRY}/${FRONTEND_IMAGE}:latest'
                    sh 'docker tag ${BACKEND_IMAGE}:latest ${REGISTRY}/${BACKEND_IMAGE}:latest'
                    sh 'docker push ${REGISTRY}/${FRONTEND_IMAGE}:latest'
                    sh 'docker push ${REGISTRY}/${BACKEND_IMAGE}:latest'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
