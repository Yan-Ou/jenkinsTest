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
          // sh 'v1=$(git diff HEAD^ HEAD tidb_download_pkg.json | grep "^\\+\\s" | grep -o \'".*"\' | sed \'s/"//g\') && echo $v1'
          // sh 'v2=$(git diff HEAD^ HEAD tidb_download_pkg.json | grep "^\\+\\s" | grep -o \'"v.*"\' | sed \'s/"//g\') && echo $v2'
          // sh 'echo $versions'
          // sh 'gcloud container images list-tags gcr.io/pingcap-public/coreos/etcd'
          sh 'gcloud auth configure-docker gcr.io/pingcap-public'
          sh 'git diff -U0 HEAD^ HEAD tidb_download_pkg.json | grep "^\\+\\s" | grep -o \'"v.*"\' | sed \'s/"//g\' | xargs -I{} sh -c \'docker pull pingcap/tidb:{} && docker tag pingcap/tidb:{} gcr.io/pingcap-public/tidb:{} && docker push gcr.io/pingcap-public/tidb:{}\''
          // sh 'docker pull pingcap/tidb:v5.0.0 && docker tag pingcap/tidb:v5.0.0 gcr.io/pingcap-public/tidb:v5.0.0 && docker push gcr.io/pingcap-public/tidb:v5.0.0'
        }
      }
    }
  }
}
