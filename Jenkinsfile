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
          sshagent(['ubuntu']) {
    // some block
             echo "Packing helm chart"
              sh "helm package -d ${WORKSPACE}/helm ${WORKSPACE}/webapp"
              
              sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.42.64'
              sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.42.64 cd /home/ubuntu'
              sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.42.64 helm install vishal1 webapp/webapp-0.1.0.tgz'
          }
        }
        }
        stage('Clean Up Approval'){
                steps{              
                    script {
                        timeout(time: 10, unit: 'MINUTES'){
                            input ('Proceed with deployment CleanUp?')
                        }
                    }        
                } 
            }
        stage('Cleaning Workspace') {
               steps{
                        sshagent(['ubuntu']){
                            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.42.64 helm uninstall vishal1'
                        }
                }
            }
       }
    }

