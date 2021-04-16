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
          git(
            branch: 'src',
            url: 'https://github.com/pingcap/pingcap.github.io.git'
            )
        }
      }
    }
  }

    stage('Build and Publish') {
      steps {
        container('toolbox'){
          dir('Tidb/data'){
            sh 'gcloud auth configure-docker gcr.io/pingcap-public --quiet'
            sh 'git diff -U0 90043e6a86605451c7f0849ad0fb86aa0602c6ae^..9b181075f0378654e25fddce0072e3eff1a544dc tidb_download_pkg.json | grep "^\\+\\s" | grep -o \'"v.*"\' | sed \'s/"//g\' | xargs -I{} sh -c \'docker pull pingcap/tidb:{} && docker tag pingcap/tidb:{} gcr.io/pingcap-public/tidb:{} && docker push gcr.io/pingcap-public/tidb:{}\''
          }
        }
      }
    }
  }
}
