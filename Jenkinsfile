pipeline {
  agent any

  environment {
    git_repo_branch = ""
    git_repo_URL = ""
    git_cred = ""
    PROJECT_ID   = ""
    CLUSTER_NAME = ""
    CLUSTER_ZONE = ""
    SERVICE_NAME = ""
    GCP_KEY = credentials("")
  }

  stages {
    stage("git checkout"){
        steps {
            script{
                checkout([$class: 'GitSCM', branches: [[name: "$git_repo_branch"]],
                userRemoteConfigs: [[url: "$git_repo_URL", credentialsId: "$git_cred"]],
                ])
            }
        }
    }  
    stage('Authenticate to GCP') {
      steps {
          sh '''
            gcloud auth activate-service-account --key-file=$GCP_KEY
            gcloud config set project $PROJECT_ID
            gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE
          '''
        
      }
    }

    stage('Blue-Green Deployment (Nginx)') {
      steps {
        script {
          sh """
          cd /var/lib/jenkins/workspace/k8s-blue-green
          """
          ACTIVE = sh(returnStdout: true, script: "kubectl get svc ${SERVICE_NAME} -o jsonpath='{.spec.selector.color}' || echo blue").trim()
          NEW_COLOR = (ACTIVE == 'blue') ? 'green' : 'blue'
          echo "Active color: ${ACTIVE}"
          echo "Deploying new color: ${NEW_COLOR}"

          sh """
            sed 's|COLOR|${NEW_COLOR}|g' deployment-tempate.yaml > deployment-${NEW_COLOR}.yaml
            kubectl apply -f deployment-${NEW_COLOR}.yaml
            kubectl rollout status deployment/app-${NEW_COLOR} --timeout=120s
          """

          sh "kubectl patch svc ${SERVICE_NAME} -p '{\"spec\":{\"selector\":{\"app\":\"myapp\",\"color\":\"${NEW_COLOR}\"}}}'"

          sh "kubectl delete deployment app-${ACTIVE} --ignore-not-found"
        }
      }
    }
  }

  post {
    success {
      echo "Blue-Green Nginx deployment completed successfully!"
    }
    failure {
      echo "Deployment failed!"
    }
  }
}
