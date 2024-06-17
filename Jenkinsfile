pipeline {
	agent any
	environment {
		registry="davidcursobigdata/prueba"
		registryCredentials="dockerhub"
		projectVersion="1.0"
		repository="https://github.com/davidcursobigdata/curso.git"
		repositoryCredentials="github"
	}
	stages{
	    stage('Clean Workspace'){
        	    steps{
                	cleanWs()
            		}
        	}
    	stage('Checkout code'){
            steps{
                script{
                    git branch: 'main',
                        credentialsId: repositoryCredentials,
                        url: repository
                }
            }
        }
       stage('Build'){
            steps{
                script{
                    dockerImage= docker.build registry
                }
            }
        }

        stage('Test'){
            steps{
                script{
                    try{
                        sh 'docker run --name test $registry'
                    }finally{
                        sh 'docker rm test'
                    }

                }
            }
        }
        stage('Deploy'){
            steps{
                script{
                    docker.withRegistry('',registryCredentials ){
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Cleaning Up'){
            steps{
                script{
                    sh 'docker rmi $registry'
                }
            }
        }	

	}
	post{
		unsuccessful{
			echo 'El pipeline ha fallado.'
		}	

	}		


}
