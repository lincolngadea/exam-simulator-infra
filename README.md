# ExamSimulator Infrastructure

Este repositório gerencia toda a infraestrutura do ExamSimulator na AWS utilizando Terraform.

## Pré-requisitos

- Terraform 1.x
- AWS CLI configurada (para testes locais)
- Credenciais AWS configuradas como segredos no GitHub:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - AWS_REGION
  - EB_APP_NAME
  - EB_ENV_NAME

## Estrutura

- `env/`: Configurações por ambiente (staging, production)
- `modules/`: Módulos Terraform reutilizáveis
- `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`: Configuração raiz

## Como usar

1. **Inicializar o Terraform**

   ```bash
   terraform init