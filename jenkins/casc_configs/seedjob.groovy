pipelineJob('nginx_main') {
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
            triggers {
                scm('*/15 * * * *')
            }
            scriptPath('Jenkinsfile_main')
        }
    }
} 

pipelineJob('nginx_test') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        github('2Core3/Diplom_nginx', 'ssh')
                        credentials('github_ssh')
                    }
                    branch('test')
                }
            }
            triggers {
                scm('* * * * *')
            }
            scriptPath('Jenkinsfile_test')
        }
    }
} 