# ⚙️ Infraestrutura - DynamoDB com Terraform

Este módulo define e provisiona a infraestrutura básica para persistência de dados de alunos e seus respectivos cadastros escolares utilizando **AWS DynamoDB** e **Terraform**.

---

## 📌 Visão Geral

A infraestrutura provisionada contempla 4 tabelas no DynamoDB, cada uma com sua chave primária `id` do tipo `String` e billing em modo `PAY_PER_REQUEST` (sob demanda).

### 🧾 Tabelas criadas:

| Tabela           | Chave Primária | Tipo da Chave | Descrição                                      |
|------------------|----------------|---------------|------------------------------------------------|
| `tbl_candidato`  | `id`           | `String`      | Armazena informações de candidatos             |
| `tbl_curso`      | `id`           | `String`      | Tabela para catálogo de cursos                 |
| `tbl_aluno`      | `id`           | `String`      | Alunos matriculados após admissão              |
| `tbl_pagamento`  | `id`           | `String`      | Controle de pagamentos efetuados pelos alunos |

---

## ☁️ Armazenamento do estado remoto

Este projeto utiliza **backend remoto via S3 com DynamoDB** para controle de estado e locking de concorrência em execuções simultâneas.

### 📦 Requisitos:

- **S3 Bucket:** `hub-colegio-admissao-aluno-terraform`
- **Tabela DynamoDB para lock:** `terraform-lock`
  - Chave primária: `LockID` (tipo `String`)

---

## 📁 Estrutura dos arquivos

```bash
infra/
├── main.tf                  # Provider e chamada do módulo
├── variables.tf             # Variáveis de entrada
├── terraform.tfvars         # Valores das variáveis
├── outputs.tf               # Outputs (caso precise)
└── modules/
    └── dynamodb/
        ├── main.tf          # Criação das tabelas DynamoDB
        └── outputs.tf       # Exporta nomes das tabelas
```

---

## 🚀 Como utilizar

1. Acesse a pasta:

```bash
cd infra
```

2. Inicialize o Terraform com backend remoto:

```bash
terraform init -reconfigure
```

3. Aplique a infraestrutura:

```bash
terraform apply -auto-approve
```

---

## ✅ Pré-requisitos

- AWS CLI configurada
- Terraform >= 1.6.6
- Permissões AWS:
  - `dynamodb:*`
  - `s3:*`
  - `iam:Get*`, `sts:Get*`

---

## 📤 Outputs esperados

Ao final da execução, você verá os nomes das tabelas criadas como output:

```bash
candidato_table = tbl_candidato
curso_table     = tbl_curso
aluno_table     = tbl_aluno
pagamento_table = tbl_pagamento
```

---

## ✨ Observações

- O uso do `billing_mode = "PAY_PER_REQUEST"` garante escalabilidade automática e evita surpresas com throughput provisionado.
- O uso de `modules` permite reutilização e separação lógica da infraestrutura.

---

## 🧠 Autor & Projeto

Este módulo faz parte do projeto **[hub-colegio-admissao-aluno](https://github.com/JesseSBezerra/hub-colegio-admissao-aluno)**, que visa modernizar e automatizar a jornada de matrícula em instituições de ensino.

Desenvolvido por [@JesseSBezerra](https://github.com/JesseSBezerra) 💡
