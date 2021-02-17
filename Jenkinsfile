node{
    stage('Checkout SCM') {
       checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '539c792a-56e7-4b63-942e-26ee412f7bfe', url: 'https://github.com/Qaroev/jenkins-app.git']]])   }

    stage('Build dockerfile') {
     docker.build('temp/temp')
    }

    stage('Publish build-info') {
     try {
        sh 'docker rm jenkinsapp --force'
     } catch (exc) {

     }
        sh 'docker create --name jenkinsapp${BUILD_NUMBER} temp/temp'
        sh 'docker cp jenkinsapp${BUILD_NUMBER}:./ng-app/dist/build-latest.zip .'
        sh 'docker rm jenkinsapp${BUILD_NUMBER} --force'
        sh 'docker rmi temp/temp --force'
        sh 'curl -v --user ${admin}:${AP2A3ijtMQrrF3bBJN9WvVf6jxf} -T build-latest.zip -X PUT "http://18.159.82.82:8082/artifactory/example-repo-local/bobojon/${NODE_NAME}/jenkinsapp-${MYTOOL_VERSION}.${BUILD_NUMBER}.zip"'
    }

}
