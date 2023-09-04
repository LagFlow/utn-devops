pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                deleteDir()
                sh 'git clone https://github.com/LagFlow/utn-devops-nextjs-app.git app'
                sh 'cd app && npm i'
            }
        }
        stage('Test') {
            steps {
                sh 'cd app && npm run test'
            }
        }
    }
}
