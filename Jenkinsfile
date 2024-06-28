pipeline {
    agent any
    parameters {
        string(name: 'LIMIAR_DISTANCIA', defaultValue: '3', description: 'Limiar de distância para considerar uma pergunta')
        string(name: 'PERGUNTAS', defaultValue: 'Como você está?|Qual é o seu nome?|Qual o animal mais rápido do mundo?', description: 'Perguntas separadas por |(pipe)')
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
                    sh "echo ${params.PERGUNTAS.split('|'))}"
                    // for (pergunta in perguntas) {
                    //     sh "python3 chat_bot.py ${params.LIMIAR_DISTANCIA} ${pergunta}"
                    // }
                }
            }
        }
    }
}