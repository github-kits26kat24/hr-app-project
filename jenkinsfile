 pipeline {
    agent any 

    stages {
        stage ('download and run') {
            environment  {
                ANSIBLE_HOST_KEY_CHECKING = 'False'
            }
            steps { 
                ansiblePlaybook(
                    credentialsId: 'SSH_AGENT_CONNECT', 
                    inventory: 'inventories/dev', 
                    playbook: 'playbook.yml'
                )
            }
        }
            stage ('web deploy') {
            environment  {
                ANSIBLE_HOST_KEY_CHECKING = 'False'
            }
            steps { 
                ansiblePlaybook(
                    credentialsId: 'SSH_AGENT_CONNECT', 
                    inventory: 'inventories/dev', 
                    playbook: 'webdeploy.yml'
                )
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}
    
