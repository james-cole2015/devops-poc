output "rds-key" {
  value = aws_kms_key.rds_encryption_key
}
output "rds-password" {
  value = data.aws_secretsmanager_secret_version.rds-password.secret_string
}

output "directory-password" {
  value = data.aws_secretsmanager_secret_version.directory-password.secret_string
}

output "vpn-password" {
  value = data.aws_secretsmanager_secret_version.vpn-password.secret_string
}