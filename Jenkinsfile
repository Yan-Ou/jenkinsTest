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
          sh 'versions=$(git diff --unified=0 HEAD^ HEAD > git.txt)'
          sh 'echo $versions'
          sh 'gcloud container images list-tags gcr.io/pingcap-public/coreos/etcd'
        }
      }
    }
  }
}
