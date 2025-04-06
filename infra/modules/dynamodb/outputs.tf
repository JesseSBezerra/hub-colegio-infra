output "candidato_table" {
  value = aws_dynamodb_table.tbl_candidato.name
}

output "curso_table" {
  value = aws_dynamodb_table.tbl_curso.name
}

output "aluno_table" {
  value = aws_dynamodb_table.tbl_aluno.name
}

output "pagamento_table" {
  value = aws_dynamodb_table.tbl_pagamento.name
}
