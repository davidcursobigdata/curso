pipeline {
	agent any
	environment {
		registry="davidcursobigdata/prueba-jenkins"
		registryCredentials="dockerhub"
		project="prueba-jenkins"
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
                        sh 'docker run --name $project -e "" $registry'
                    }finally{
                        sh 'docker rm $project'
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
