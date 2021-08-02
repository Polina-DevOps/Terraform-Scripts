pipeline {
    agent {
        label 'workstation'
    }
    parameters {
        choice(name: 'CHOICE', choices: ['CREATE', 'DESTROY'], description: 'Pick something')
    }
    stages {
        stage('TERRAFORM_INIT') {
            steps {
                echo 'Running terraform init..'
                sh 'hostname'
                sh 'cd roboshop-terraform ; terraform init'
            }
        }

    stage('TERRAFORM_APPLY') {
        when {
            environment name: 'CHOICE', value: 'CREATE'
        }
        steps {
               echo 'Running terraform apply..'
               sh 'hostname'
               sh 'cd roboshop-terraform ; terraform apply -auto-approve'
            }
        }

    stage('TERRAFORM_Destroy') {
        when {
            environment name: 'CHOICE', value: 'DESTROY'
        }
        input {
            message "Should we continue?"
            ok "Yes, we should."
        ##    submitter "alice,bob"
        ##    parameters {
        ##           string(name: 'PERSON', defaultValue: 'admin', description: 'Who should I say hello to?')
        ##    }
        }
        steps {
               echo 'Running terraform Destroy..'
               sh 'hostname'
               sh 'cd roboshop-terraform ; terraform destroy -auto-approve'
            }
        }
    }
}