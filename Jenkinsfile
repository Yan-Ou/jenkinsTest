pipeline {
  // agent {
  //   kubernetes {
  //     defaultContainer 'jnlp'
  //     yamlFile 'jenkins-slave-pod.yaml'
  //   }
  // }
  agent any

  stages {
  //   stage("Cleanup") {
  //     steps {
  //       container('toolbox'){
  //         deleteDir()
  //       }
  //     }
  //   }

    stage("Checkout Code") {
      steps {
        script{
          node {
            docker.image('gcr.io/pingcap-public/sre-toolbox:v0.0.1'){
              dir('Tidb'){
              git(
                branch: 'src',
                url: 'https://github.com/pingcap/pingcap.github.io.git'
                )
              }
            }
          }
        }
      }
    }

  //   stage('Build and Publish') {
  //     steps {
  //       // container('toolbox'){
  //       node{
  //       docker.image('gcr.io/pingcap-public/sre-toolbox:v0.0.1'){
  //         dir('Tidb/data'){
  //           sh 'gcloud auth configure-docker gcr.io/pingcap-public --quiet'
  //           sh """git diff -U0 HEAD^ HEAD tidb_download_pkg.json | grep "^\\+\\s" | grep -o \'"v.*"\' | sed \'s/"//g\' | \
  //           xargs -I{} sh -c \'docker pull pingcap/tidb:{} && docker pull pingcap/tikv:{} && docker pull pingcap/br:{} && docker tag pingcap/tidb:{} gcr.io/pingcap-public/tidb:{} \
  //           && docker tag pingcap/tikv:{} gcr.io/pingcap-public/tikv:{} && docker tag pingcap/br:{} gcr.io/pingcap-public/br:{} \
  //           && docker push gcr.io/pingcap-public/tidb:{} && docker push gcr.io/pingcap-public/tikv:{} && docker push gcr.io/pingcap-public/br:{}\'"""
  //         }
  //       }
  //     }
  //   }
  // }
}
}
