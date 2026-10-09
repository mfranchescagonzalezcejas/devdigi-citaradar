pipeline {
    agent any
    stages {
        stage('Checkout') { steps { checkout scm } }
        stage('Setup') {
            steps { sh 'python3 -m venv .venv && .venv/bin/python -m pip install -e ".[dev]"' }
        }
        stage('Static analysis') {
            steps { sh '.venv/bin/python -m ruff check .' }
        }
        stage('Unit tests (offline only)') {
            steps { sh '.venv/bin/python -m pytest -q --junitxml=test-results/junit.xml' }
        }
        stage('Package sanity') {
            steps { sh '.venv/bin/python -m compileall -q src/' }
        }
    }
    post {
        always {
            junit allowEmptyResults: true, testResults: 'test-results/junit.xml'
            archiveArtifacts allowEmptyArchive: true, artifacts: 'test-results/junit.xml'
        }
    }
}
