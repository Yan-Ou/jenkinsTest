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
          dir('Tidb'){
          git branch: 'master',
          url: 'https://github.com/pingcap/pingcap.github.io.git'
        }
          // sh 'ls -al && pwd'
      }
    }
  }

    stage('Build and Publish') {
      steps {
        container('toolbox'){
          dir('Tidb/data'){
            sh 'pwd'
            sh 'ls -al'
            sh 'gcloud auth configure-docker gcr.io/pingcap-public --quiet'
            sh 'git diff -U0 HEAD^ HEAD tidb_download_pkg.json | grep "^\\+\\s" | grep -o \'"v.*"\' | sed \'s/"//g\' | xargs -I{} sh -c \'docker pull pingcap/tidb:{} && docker tag pingcap/tidb:{} gcr.io/pingcap-public/tidb:{} && docker push gcr.io/pingcap-public/tidb:{}\''
          }
        }
      }
    }
  }
}
