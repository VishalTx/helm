pipeline {
    agent any
    
    stages {
       

        stage('Build image') {
            steps {
                sh 'docker build -t manishaverma/helm:${BUILD_NUMBER} .'
            
            }
        }

        stage('Push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    sh 'docker push manishaverma/helm:${BUILD_NUMBER}'
                    sh 'docker -t manishaverma/helm:${BUILD_NUMBER} manishaverma/helm:latest'
                    sh 'docker push manishaverma/helm:latest'
                    sh 'sleep 10'
                }
            }
        }
        

        stage ('Helm Deploy') {
            steps {
                
             echo "Packing helm chart"
              sh "helm package -d ${WORKSPACE}/webapp ${WORKSPACE}/webapp"
              
            
        }
        }
        stage ('updating the package to Jfrog'){
            steps{
                 withCredentials([string(credentialsId: 'jfrog', variable: 'JFROG_CREDENTIALS')]){
                sh 'curl -u vishal.sader@testingxperts.com:${JFROG_CREDENTIALS} -T ${WORKSPACE}/webapp/webapp-0.1.0.tgz "https://testingxperts.jfrog.io/artifactory/helm/"'
                sh "rm -f ${WORKSPACE}/webapp/webapp-0.1.0.tgz"
                 }
          }
         }
       }
    }

