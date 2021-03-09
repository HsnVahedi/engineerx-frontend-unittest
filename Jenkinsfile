pipeline {
    agent {
        docker {
            image 'hsndocker/cluster-control:latest'
            args '-u root:root -v /home/hossein/.kube:/root/.kubecopy:ro -v /home/hossein/.minikube:/root/.minikube:ro'
        }
    }
    
    parameters {
        string(name: 'FRONTEND_VERSION', defaultValue: 'latest')
    }
    environment {
        DOCKERHUB_CRED = credentials('dockerhub-repo')
        FRONTEND_VERSION = "${params.FRONTEND_VERSION}"
        BUILD_ID = "${env.BUILD_ID}"
    }
    stages {
        stage('Configure kubectl and terraform') {
            
            steps {
                sh 'cd /root && cp -r .kubecopy .kube'
                sh 'cd /root/.kube && rm config && mv minikube.config config'
                sh 'cp /root/terraform/terraform .'
                sh 'cp /root/kubectl/kubectl .'
            }
        } 
        stage('Deploy Frontend Unittest') {
            steps {
                sh './terraform init'
                sh('./terraform apply -var test_number=$BUILD_ID -var frontend_version=$FRONTEND_VERSION -var dockerhub_username=$DOCKERHUB_CRED_USR -var dockerhub_password=$DOCKERHUB_CRED_PSW --auto-approve')
                sh "./kubectl wait --for=condition=ready --timeout=600s -n frontend-unittest pod/unittest-${env.BUILD_ID}" 
		sh "./kubectl exec -n frontend-unittest unittest-${env.BUILD_ID} -c frontend -- npm run test"
            }
            post {
                always {
                    sh "./terraform destroy -var test_number=${env.BUILD_ID} -var frontend_version=${params.FRONTEND_VERSION} --auto-approve"
                }
            }
        }
        
        // stage('Invoke Setting latest tags') {
        //     steps {
        //         build job: 'engineerx-backend-latest-tag', parameters: [
        //             string(name: "BACKEND_VERSION", value: "${params.BACKEND_VERSION}")
        //         ]
        //     }
        // }
    }
}
