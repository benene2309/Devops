node {
    properties([
        disableConcurrentBuilds(),
        buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '5', artifactNumToKeepStr: '1'))
    ])
        stage('checkout') {
            checkout scm 
        }
        docker.image('openjdk:8').inside('-u root -v $HOME/.m2:/root/.m2') {
            try {
                stage('check java') {
					sh "env"
                    sh "java -version"
                }
                stage('clean') {
                    sh "chmod +x mvnw"
                    sh "./mvnw clean"
                }

                stage('packaging') {
                    sh "./mvnw package -Pprod -DskipTests"
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
                
	
            } finally {
                sh "chmod -R 777 ."
            }
        }
    	 def dockerImage
        stage('build docker') {
            sh "pwd"
            sh "ls -lrt target"
            sh "env"
            sh "/bin/ip addr show"
            dockerImage = docker.build("${env.DOCKER_IMAGE_NAME}", '.')
		}

        stage('publish docker') {
            docker.withRegistry("${env.DOCKER_REPO}", "${env.DOCKER_CRED}") {
				dockerImage.push "${env.DOCKER_VERSION}"
			}
        }

        

}