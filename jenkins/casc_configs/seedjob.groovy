pipelineJob('nginx_deploy') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        github('2Core3/Diplom_nginx', 'ssh')
                        credentials('github_ssh')
                    }
                    branch('main')
                }
            }
            scriptPath('Jenkinsfile')
        }
    }
} 

multibranchPipelineJob('main_and_test') {
    branchSources {
        github {
            id('23232323') // IMPORTANT: use a constant and unique identifier
            scanCredentialsId('github_PAT')
            repoOwner('2Core3')
            repository('Diplom_nginx.git')    
            triggers {
                urlTrigger {
                    url('https://github.com/2Core3/Diplom_nginx.git') {
                        check('status')
                    }
                }
            }
        }
    }
}