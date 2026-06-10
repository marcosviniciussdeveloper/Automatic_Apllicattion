# 🚀 Automated AWS Infrastructure with Terraform & GitHub Actions

Este repositório contém uma solução completa de **Infraestrutura como Código (IaC)** para provisionamento automatizado de recursos na AWS utilizando **Terraform** e integração contínua com **GitHub Actions**.

O projeto segue boas práticas de DevOps e Cloud Infrastructure, incluindo:

* Backend remoto com Amazon S3
* Pipeline CI/CD automatizado
* Gestão segura de credenciais com GitHub Secrets
* Estrutura modular e escalável
* Automação completa do deployment

---

# 🏗️ Arquitetura da Solução

O fluxo abaixo representa o ciclo completo de automação da infraestrutura:

1. O desenvolvedor realiza um `git push` para a branch `main`
2. O GitHub Actions executa automaticamente o pipeline
3. O Terraform inicializa o backend remoto no S3
4. O plano e aplicação da infraestrutura são executados
5. Os recursos são provisionados automaticamente na AWS

## 📌 Diagrama da Arquitetura

```markdown
![Diagrama de Arquitetura](./images/Arquitetura.drawio.png)
```

> Coloque a imagem do diagrama dentro da pasta `images/` com o nome:
>
> `Arquitetura.drawio.png`

---

# 📂 Estrutura do Projeto

```bash
├── .github/
│   └── workflows/
│       └── terraform.yml       # Pipeline automatizado GitHub Actions
│
├── images/
│   └── Arquitetura.drawio.png  # Diagrama da arquitetura
│
├── src/
│   ├── main.tf                 # Recursos principais AWS
│   ├── provider.tf             # Provider AWS + Backend S3
│   ├── variables.tf            # Declaração de variáveis
│   ├── terraform.tfvars        # Valores locais das variáveis
│   └── outputs.tf              # Outputs da infraestrutura
│
└── README.md
```

---

# 🛠️ Tecnologias Utilizadas

* Terraform v1.15.1
* AWS CLI
* GitHub Actions
* Amazon S3
* Draw.io
* Git
* Linux (Ubuntu Runner)

---

# 🚀 Pipeline de CI/CD (GitOps)

O workflow está configurado no ficheiro:

```bash
.github/workflows/terraform.yml
```

## 🔄 Etapas Automatizadas

### 1. Checkout do Código

Descarrega automaticamente o repositório para o runner Linux (`ubuntu-latest`).

### 2. Configuração das Credenciais AWS

Autentica na AWS utilizando credenciais seguras armazenadas no GitHub Secrets.

### 3. Setup do Terraform

Instala exatamente a versão:

```bash
Terraform v1.15.1
```

Garantindo consistência entre ambiente local e pipeline.

### 4. Terraform Init

Inicializa o backend remoto utilizando as variáveis secretas do GitHub.

### 5. Terraform Plan

Valida e planeia as alterações da infraestrutura.

### 6. Terraform Apply

Aplica automaticamente as alterações na AWS usando:

```bash
-auto-approve
```

---

# 🔐 Configuração de Segurança (GitHub Secrets)

Configure as seguintes variáveis em:

```bash
Settings > Secrets and variables > Actions
```

| Secret                | Descrição                |
| --------------------- | ------------------------ |
| AWS_ACCESS_KEY_ID     | ID da Access Key AWS     |
| AWS_SECRET_ACCESS_KEY | Secret Access Key AWS    |
| AWS_BUCKET_NAME       | Nome do bucket S3 remoto |
| AWS_BUCKET_FILE       | Nome do ficheiro tfstate |

## 📌 Exemplo

```bash
AWS_BUCKET_NAME=devopsbuckets3-061051244778-us-east-1-an
AWS_BUCKET_FILE=terraform.tfstate
```

---

# 💻 Execução Local

Antes de executar localmente:

## 1. Configurar AWS CLI

```bash
aws configure
```

---

## 2. Inicializar Terraform

Dentro da pasta `src/` execute:

```bash
terraform init \
  -backend-config="bucket=devopsbuckets3-061051244778-us-east-1-an" \
  -backend-config="key=terraform.tfstate"
```

---

## 3. Validar o Plano

```bash
terraform plan
```

---

## 4. Aplicar Infraestrutura

```bash
terraform apply
```

---

# ☁️ Backend Remoto Terraform

O estado da infraestrutura (`terraform.tfstate`) é armazenado remotamente no Amazon S3 para:

* Segurança
* Consistência
* Colaboração entre equipas
* Evitar conflitos de estado

---

# 🔒 Boas Práticas Implementadas

* Uso de GitHub Secrets
* Backend remoto S3
* Automação CI/CD
* Versionamento da infraestrutura
* Separação de ambientes
* Pipeline reproduzível
* IaC declarativa

---

# 📈 Possíveis Melhorias Futuras

* Integração com Terraform Cloud
* Ambiente staging/prod
* Uso de módulos Terraform
* Integração com SonarQube
* Pipeline com aprovação manual
* Integração com CloudWatch
* Deploy multi-account AWS

---

# 👨‍💻 Autor

Projeto desenvolvido como parte do plano de especialização em:

* DevOps
* Cloud Infrastructure
* AWS
* Infrastructure as Code (IaC)
* GitOps

---

# 📜 Licença

Este projeto está sob a licença MIT.
