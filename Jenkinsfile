
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
                             docker.run -d '-p8088:8089' testnode
                             sh "ls -la ${pwd()}"
                             sleep 100
                             docker.image('python:2.7.18-slim-stretch').inside('-p8188:8188') {
                                            
                                            sh 'cd ./src/test'
                                            sh 'ls -l'
                                            sh 'pip install -r ./src/test/requirements.txt'
                                            sh 'ls -l src'
                                            sh 'python ./src/test/e2e_test.py "0.0.0.0:8088" "./src/test/e2e" "2"'
                                            sh 'python ./src/test/e2e_test.py "0.0.0.0:8088" "./src/test/sanity" "2"'

                                            
                                    }

                            
                           
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
