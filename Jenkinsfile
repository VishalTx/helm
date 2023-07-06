pipeline {
    agent any
   
 
    stages {
        // stage('Clone repository') {
        //     steps {
        //         git 'https://github.com/Manisha148/Task-K8.git'
        //     }
        // }

        stage('Build image') {
            steps {
                sh 'docker build -t manishaverma/helm .'
            }
        }

        stage('Push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    sh 'docker push manishaverma/helm'
                }
            }
        }

       // stage('Deploy Helm chart') {
       //      steps {
                
       //          sh "helm install vishal-helm /home/ubuntu/mywebapp/webapp/webapp-0.1.0.tgz  --namespace default --set controller.publishService.enabled=true --set controller.service.loadBalancerIP=${env.LB_IP}"
       //      }
       //  }
        stage ('Helm Deploy') {
            steps {
                
             echo "Packing helm chart"
              sh "helm package -d ${WORKSPACE}/webapp ${WORKSPACE}/webapp"
              
            
        }
        }
        stage ('updating the package to Jfrog'){
            steps{
                 
                sh 'curl -u vishal.sader@testingxperts.com:cmVmdGtuOjAxOjE3MjAxNTg4NjQ6RGV6ZVRCaTZoYkVrVE15TFlVbk5NQVpRcGVZ -T ${WORKSPACE}/webapp/webapp-0.1.0.tgz "https://testingxperts.jfrog.io/artifactory/helm/"'
            
          }
         }
       }
    }

