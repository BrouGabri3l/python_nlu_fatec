pipeline {
    agent any
    parameters {
        string(name: 'LIMIAR_DISTANCIA', defaultValue: '3', description: 'Limiar de distância para considerar uma pergunta semelhante')
        string(name: 'PERGUNTAS', defaultValue: 'Como você está?|Qual é o seu nome?', description: 'Perguntas separadas por |')
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
                    def perguntas = params.PERGUNTAS.split(' \\|').collect { it.trim() }.join(' ')
                    sh 'python3 chat_bot.py ${params.LIMIAR_DISTANCIA} ${perguntas}'
                }
            }
        }
    }
}