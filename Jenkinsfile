
pipeline{
    agent any
    tools {
        maven "3.6.2"
        jdk "java_08"
    }
    environment{
        APP_NAME='suggest-lib-mbp'
    }
    stages{
        stage("Checkout"){
            steps{
                checkout scm
            }
            post{
                success{
                    echo "========Executed successfully========"
                }
                failure{
                    echo "========Eexecution failed========"
                }
            }
        }
        

           
                
           stage("build"){
                   
                    steps{
                        script{
                            env.VERSION='1.6'
                            withMaven(maven: '3.6.2', jdk: 'java_08', mavenSettingsConfig: 'suggest-lib-id') {
                            sh """
                               
                                mvn deploy
                            """
                            stash name:'target', includes:'*'
                            }
                        }
                    }
            }
            stage("e2e java"){
                
                   
                    steps{
                        unstash 'target'
                        script{  
                            sh "ls -la ${pwd()}"
                            docker.image('openjdk:8-jre').inside{c ->
                               
                                sh "pwd"
                                sh"ls -l"

                                sh 'sleep 2'
                                sh 'curl http://0.0.0.0:8089'
                            // Run command
                            }
                        }
                        
                    }
            }

            stage("e2e python"){
                agent { docker 'python:2.7.18-slim-stretch' }
                steps{
                   sh "ls -la ${pwd()}"
                    echo 'python'
                    sh 'printenv'
                }

            }

            stage("deploy"){
                   
                    steps{
                        echo "this is deploy stage"
                        
                        
                    }
            }
            
        
    }
    post{
        always{
            cleanWs()
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
