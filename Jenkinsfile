#!/usr/bin/env groovy

pipeline {
    agent {
        kubernetes {
            cloud 'azure-ocp-sandbox'
            namespace 'azure-jenkins'
            serviceAccount 'jenkins'
            yamlFile 'jenkins-pod.yml'
            defaultContainer 'jnlp'
        }


    }

environment {
    HELM_RELEASE_NAME="nodejs-template"
}
    stages {
        stage(' Main ') {
            steps {
                sh 'hostname'
                sh 'env'
            }
        }

        stage(' Maven package ') {
            steps {
                sh 'npm install'
            }
        }

        stage(' Maven test ') {
            steps {
                sh 'npm test'
            }
        }

        stage('helm program itself install') {
            steps {
                sh '''
                curl -o ${JENKINS_AGENT_WORKDIR}/helm.tar.gz  https://get.helm.sh/helm-v3.6.3-linux-amd64.tar.gz
                # checksum: 07c100849925623dc1913209cd1a30f0a9b80a5b4d6ff2153c609d11b043e262
                tar -zxvf ${JENKINS_AGENT_WORKDIR}/helm.tar.gz
                chmod +x ${WORKSPACE}/linux-amd64/helm
                ${WORKSPACE}/linux-amd64/helm help
                '''
            }
        }

	    stage(' helm status APP ') {
            steps {
                sh '${WORKSPACE}/linux-amd64/helm status nodejs-template'
            }
        }

        stage(' Helm Install or Upgrade APP ') {
            steps {
                sh '${WORKSPACE}/linux-amd64/helm --debug upgrade --install nodejs-template helm'
            }
        }

	    stage(' create image via BC ') {
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS'
              }
            }
           steps {
	            sh 'oc start-build nodejs-template-helm --follow -n nodejs-template'
            }
        }

       stage ('image signing') {
	        steps {
	            sh 'echo "Image singing is todo, see https://github.com/redhat-cop/image-scanning-signing-service."'
	        }
	    }

        stage ('image copy to jfrog') {
            steps {
                sh 'echo "placing container in jfrog including signing is still todo." '
            }
        }

    }
}


