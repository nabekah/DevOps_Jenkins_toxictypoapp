import groovy.json.JsonSlurper
import groovy.json.JsonOutput
import groovy.json.JsonSlurper
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
        stage("Build"){
            parallel{
                stage("A"){
                    when{
                        branch "main"
                    }
                    steps{
                        script{
                            env.VERSION='1.6'
                            withMaven(maven: '3.6.2', jdk: 'java_08', mavenSettingsConfig: 'suggest-lib-id') {
                            sh """
                                //mvn versions:set -DnewVersion=0.0.1-SNAPSHOT-1.4
                                mvn verify
                            """
                            }
                        }
                    }
                }
                stage("B"){
                    when{
                        branch "release/*"
                    }
                    steps{
                        script{
                            println("this is the release branch name ${env.BRANCH_NAME}")
                            env.VERSION=getVersionFromReleaseBranch("${env.BRANCH_NAME}")
                            env.APP_3_NUMBER_TAG = get_next_3_number_version("${APP_NAME}", "${VERSION}")
                            env.newVersion = getImageTag("${APP_3_NUMBER_TAG}", "${VERSION}")
                            withMaven(maven: '3.6.2', jdk: 'java_08', mavenSettingsConfig: 'suggest-lib-id') {
                            sh"""
                                mvn versions:set -DnewVersion=${newVersion} 
                                mvn deploy
                                git config --global user.email abekah.ekow@gmail.com"
                                git config --global user.name "noah"
                                git clean -f
                                git tag v=${APP_3_NUMBER_TAG}
                                git push --tags
                            """
                            saveVersion("${APP_NAME}", "${VERSION}", "${APP_3_NUMBER_TAG}")
                            }
                        }
                    }
                }
                stage("C"){
                    when {
                        not {
                            anyOf {
                                branch "main";
                                branch "release/*"
                            }
                        }
                    }
                    steps{
                        echo "this is neither release nor main"
                        withMaven(maven: '3.6.2', jdk: 'java_08', mavenSettingsConfig: 'suggest-lib-id') {
                            sh """
                                mvn verify
                            """
                        }
                    }
                }
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
def readVersiondb(){
    // Create map object
    def version_db = [:]
    filename = "/var/jenkins_home/version_db.json"
    File file = new File(filename)
    if (file.exists()){
        // Load json data from file
        def json_data = new JsonSlurper()
        version_db = json_data.parse(file)
        assert version_db instanceof Map
    }
    return version_db
}
def saveVersion(app_image_name,version, three_number_version){
    def version_db = readVersiondb()
    println(version_db)
    def key = "${app_image_name}${version}"
    filename = "/var/jenkins_home/version_db.json"
    // Create file object
    File file = new File(filename)
    if (file.exists()){
        if (version_db.containsKey(key)){
            // Add current version to db
            version_db[key].add(three_number_version)
        }else{
            // Add initial major and manor version
            version_db[key] = [three_number_version]
        }
    }else{
        // Add initial major and manor version
        version_db[key] = [three_number_version]
    }
    // Write data to file
    def json_str = JsonOutput.toJson(version_db)
    def vdb_json = JsonOutput.prettyPrint(json_str)
    file.write(vdb_json)
}
def get_next_3_number_version(app_image_name, version){
    def key = "${app_image_name}${version}"
    def version_db = readVersiondb()
    def last_version = ""
    def new_3_number_version = ""
    if (version_db.containsKey(key)){
        // Get last version
        last_version = version_db[key][-1]
        // Split last version
        def (major, minor, patch) = last_version.tokenize('.')
        // Caculate new patch
        int new_patch = patch.toInteger() + 1
        // Format new 3 number version
        new_3_number_version = "${major}.${minor}.${new_patch}"
    }else{
        // Format initial 3 number version
        new_3_number_version = "${version}.1"
    }
    return new_3_number_version
}
def getImageTag(three_number_version, majar_minor_version){
    // Get patch number
    def (major, minor, patch) = three_number_version.tokenize('.')
    int patch_int = patch.toInteger()
    if (patch_int == 1){
        return majar_minor_version
    }
    return three_number_version
}
def getVersionFromReleaseBranch(branch){
    def (name, version) = branch.tokenize('/')
    return version
}
