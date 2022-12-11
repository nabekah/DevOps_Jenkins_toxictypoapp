
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
                    echo "========checkout Executed successfully========"
                }
                failure{
                    echo "========checkout Eexecution failed========"
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
            stage("e2e test"){
                
                   
                    steps{
                        unstash 'target'
                        script{  
                         dockerNode = docker.build("testnode", ".")
                          
                        }
                        
                    }
            }

            stage("e2e python"){
                
                steps{
                   unstash 'target'
                   
                    
                   
                    script{
                      
                      sh  "docker run -d -p8088:8089 -w /app testnode"
                       sleep 2
                    }
                       
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
