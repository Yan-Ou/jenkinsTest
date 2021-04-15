pipeline {
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yamlFile 'jenkins-slave-pod.yaml'
    }
  }

  environment {
    VAULT_ADDR = credentials("vault-addr")
    VAULT_TOKEN = credentials("vault-token")
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
          sh 'gcloud config set project pingcap-public'
          sh 'gcloud container images list-tags gcr.io/pingcap-public/coreos/etcd'
        }
      }
    }
  }
}
