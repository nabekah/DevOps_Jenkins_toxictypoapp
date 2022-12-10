
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
                        script{  
                            sh "ls -la ${pwd()}"
                            docker.image('openjdk:8-jre').withRun('-p 8089:8080 --name java-e2e -v ${pwd}:/app', 'java - jar /app/target/toxictypoapp-1.0-SNAPSHOT.jar') {
                                
                                sh "ls -la ${pwd()}"

                                sh 'sleep 1000'
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
