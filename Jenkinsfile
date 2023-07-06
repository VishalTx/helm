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
        stage('Update GIT') {
           steps{
            script {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        //def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
                        sh "git config user.email vishal.sader@testingxperts.com"
                        sh "git config user.name VishalTx"
                        //sh "git switch master"
                        
                        sh "sed -i 's+manishaverma/helm.*+manishaverma/helm:${env.BUILD_NUMBER}+g' webapp/templates/deployment.yaml"
                        sh "cat webapp/templates/deployment.yaml"
                        sh "git add ."
                        sh "git commit -m 'Done by Jenkins Job changemanifest: ${env.BUILD_NUMBER}'"
                        sh "git push https://github.com/VishalTx/helm.git HEAD:master"
                    }
                
                }
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

