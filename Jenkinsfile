pipeline {
    agent any
    
	environment {
		PROJECT_NAME="Memory Game"
		APP_URL="http://152.42.229.180:8800/"
		APP_ENV="UAT"
		BUILD_USER="HANG DAZON"
		RELEASE_NEW="TESTING NEW FEATURE"
        // Telegram configuration
        TELEGRAM_TOKEN = credentials('telegram-credentials')
        TELEGRAM_ID = credentials('Telegram_ChatID')
    }
	stages {
        stage('Clone the repo') {
            steps {
                echo 'Cloning the repository:'
                git branch: 'main', url: 'https://github.com/HangDazon/nginx-memory-game.git'
            }
        }
		stage('Build') {
			steps {
				echo 'Building the application on Docker'
				sh 'docker build . -t memory-game'
			}
		}
        stage('Deploy') {
            steps {
                echo 'Deploying the application on Docker'
                sh 'docker-compose up -d'
            }
        }
    }
    post {
		always{
			script {
				sh """
					curl -s -X POST https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage \
							-d chat_id=${TELEGRAM_ID} \
							-d parse_mode="HTML" \
							-d disable_web_page_preview=true \
							-d text="<b>Stage</b>: Deploy Project ${PROJECT_NAME} \
							%0A<b>Status</b>: ${currentBuild.currentResult} \
							%0A<b>Version</b>: ${APP_ENV}-101 \
							%0A<b>Environment</b>: Docker-${APP_ENV} \
							%0A<b>Application URL</b>: ${APP_URL} \
							%0A<b>User Build</b>: ${BUILD_USER} \
							%0A<b>Release Note</b>: ${RELEASE_NEW}"
				"""
			}
		}
    }	
}