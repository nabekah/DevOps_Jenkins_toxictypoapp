
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
                         sleep 2
                            sh 'docker run -d -p8088:8089 -v ${PWD}:/app -w /app testnode'
                             sh "ls -la ${pwd()}"
                             sleep 100
                             

                            
                           
                        }
                        
                    }
            }

            stage("e2e python"){
                
                steps{
                   unstash 'target'
                   sh "ls -la ${pwd()}"
                    echo 'python'
                    sh 'printenv'
                    script{
                        echo "this is empy"
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
