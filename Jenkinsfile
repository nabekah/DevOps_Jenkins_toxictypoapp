
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
                            docker.image('openjdk:8-jre').withRun('-p8088:8089 --entrypoint "java" "-jar" "./target/toxictypoapp-1.0-SNAPSHOT.jar"' ){c ->
                              
                               sh "pwd"
                                sh "ls -l"
                               
                                
                                sh 'sleep 100000'
                               
                               
                            // Run command
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
