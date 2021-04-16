pipeline {
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yamlFile 'jenkins-slave-pod.yaml'
    }
  }

  stages {
    stage("Cleanup") {
      steps {
        container('toolbox'){
          deleteDir()
        }
      }
    }

    stage("Checkout Code") {
      steps {
        container('toolbox'){
          checkout scm
        }
      }
    }

    stage('Test') {
      steps {
        container('toolbox'){
          sh 'versions=$(git diff HEAD^ HEAD tidb_download_pkg.json | grep "^\\+\\s" | grep -o \'".*"\' | sed \'s/"//g\')'
          sh 'echo $versions'
          sh 'gcloud container images list-tags gcr.io/pingcap-public/coreos/etcd'
          sh 'docker pull pingcap/tidb:v5.0.0 && docker tag pingcap/tidb:v5.0.0 gcr.io/pingcap-public/tidb:v5.0.0 && docker push gcr.io/pingcap-public/tidb:v5.0.0'
        }
      }
    }
  }
}
