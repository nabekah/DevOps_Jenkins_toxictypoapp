
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
                            }
                        }
                    }
            }
            stage("e2e java"){
                
                   
                    steps{
                        
                       
                        echo 'openjdk8'
                     
                    }
            }

            stage("e2e python"){
                agent { docker 'python:2.7.18-slim-stretch' }
                steps{
                    echo 'python'
                }

            }

            stage("deploy"){
                   
                    steps{
                        echo "this is deploy stage"
                      sh "ls -la ${pwd()}"  
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
