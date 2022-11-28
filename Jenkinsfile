pipeline {
    agent  {
        label 'dind-agent'
    }
    stages {
        stage('Build image') {
            steps {
                script {
                    app = docker.build("exemplary-datum-362307/goods")
                }
            }
        }
        
        stage("Push image to gcr") {
            steps {
                script {
                    docker.withRegistry('https://asia.gcr.io', 'gcr:exemplary-datum-362307') {
                        app.push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }

        stage('K8S Manifest Update') {

            steps {

                git credentialsId: 'jenkins',
                    url: 'https://github.com/eunsi/argo_gogleshop.git',
                    branch: 'main'

                sh "sed -i 's/goods:.*\$/goods:${env.BUILD_NUMBER}/g' deploy_goods.yaml"
                sh "git add deploy_goods.yaml"
                sh "git commit -m '[UPDATE] goods ${env.BUILD_NUMBER} image versioning'"

                withCredentials([gitUsernamePassword(credentialsId: 'jenkins')]) {
                    sh "git push -u origin main"
                }
            }
            post {
                    failure {
                    echo 'Update failure !'
                    }
                    success {
                    echo 'Update success !'
                    }
            }
        }

    }             

}
