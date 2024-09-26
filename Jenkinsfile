pipeline {
    agent any

    environment {
        // Docker image URI for ECR
        DOCKER_IMAGE = '024848486869.dkr.ecr.ap-south-1.amazonaws.com/php-app-repo:latest'
        AWS_REGION = 'ap-south-1'
        // Credential IDs for AWS and GitHub
        AWS_CREDENTIALS = 'aws-credentials-id'
        GITHUB_CREDENTIALS = 'github-credentials-id'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Use GitHub credentials to clone repository
                 git branch: 'main', url: 'https://github.com/shanmathi-1420/php-rds.git', credentialsId: 'github-credentials-id'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh 'docker build -t php-app .'
                sh 'docker tag php-app:latest $DOCKER_IMAGE'
            }
        }

        stage('Push to ECR') {
            steps {
                // Use AWS credentials to login and push Docker image to ECR
                withCredentials([usernamePassword(credentialsId: "${AWS_CREDENTIALS}", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 024848486869.dkr.ecr.ap-south-1.amazonaws.com
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                // Pull Docker image on EC2 and run it
                sh '''
                    docker pull $DOCKER_IMAGE
                    docker run -d -p 8082:80 --name php-app $DOCKER_IMAGE
                '''
            }
        }
    }

    post {
        always {
            // Logout from Docker registry
            sh 'docker logout 024848486869.dkr.ecr.ap-south-1.amazonaws.com'
        }
    }
}
