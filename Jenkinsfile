pipeline {
    agent any
    parameters {
        string(name: 'LIMIAR_DISTANCIA', defaultValue: '3', description: 'Limiar de distância para considerar uma pergunta')
        string(name: 'PERGUNTAS', defaultValue: 'Como você está?|quando o Brasil foi descoberto?|Qual o animal mais rápido do mundo?', description: 'Perguntas separadas por |(pipe)')
    }
    stages {
        stage('Preparação do Ambiente') {
            steps {
                sh """
                    python3 --version
                    pip3 --version
                """
                sh 'pip install --break-system-packages -r requisitos.txt'
            }
        }

        stage('Execução do Teste Levenshtein') {
            steps {
                sh 'python3 levenshtein_teste.py'
            }
        }

        stage('Verificação do Arquivo de Perguntas') {
            steps {
                script {
                    if (fileExists('perguntas.txt')) {
                        echo 'Arquivo perguntas.txt encontrado!'
                    } else {
                        error('Arquivo perguntas.txt não encontrado. Interrompendo o pipeline.')
                    }
                }
            }
        }

        stage('Execução do Chatbot') {
            steps {
                script {
                    def perguntasList = params.PERGUNTAS.split('\\|')

                    perguntasList.each { pergunta ->
                        echo "executando: ${pergunta}"
                        sh "python3 chat_bot.py ${params.LIMIAR_DISTANCIA} '${pergunta}'"
                    
                    }
                    
                }
            }
        }
          
    }
    post {
        always {
            def mailRecipients = "gabrielrbs2004@gmail.com"
            def jobName = currentBuild.fullDisplayName
            
            mail body: '''${SCRIPT, template="groovy-html.template"}''',
                subject: "[Jenkins] ${jobName}",
                to: "${mailRecipients}"
        }
    }
}