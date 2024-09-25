pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh 'docker build -t shanmathi20/php-app .'
        sh 'docker tag shanmathi20/php-app shanmathi20/php-app:latest'
      }
    }
    
    stage('Deploy') {
      steps {
       withCredentials([usernamePassword(credentialsId: 'myuser', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin docker.io"
          sh 'docker push shanmathi20/php-app:latest'
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
