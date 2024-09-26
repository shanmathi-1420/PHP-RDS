pipeline {
  agent any

  environment {
    DOCKER_IMAGE_NAME = 'shanmathi20/php-app:latest'  
  }

  stages {
    stage('Build') {
      steps {
        sh 'docker build -t php-app .'  // You can change 'php-app' if you have a different image name.
        sh 'docker tag php-app $DOCKER_IMAGE_NAME'  
      }
    }
    
    stage('Deploy') {
      steps {
        withCredentials([usernamePassword(credentialsId: "docker-hub-credentials", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin docker.io"  // Ensure credentials ID is correct.
          sh 'docker push $DOCKER_IMAGE_NAME'  
        }
      }
    }
  }

  post {
    always {
      sh 'docker logout'
    }
  }
}

