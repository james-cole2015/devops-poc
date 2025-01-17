resource "aws_db_instance" "default" {
  allocated_storage                   = 10
  db_name                             = "challenge_db"
  identifier                          = "challengedb"
  engine                              = "postgres"
  engine_version                      = "14.1"
  instance_class                      = "db.t3.micro"
  username                            = "rdsanalyst"
  password                            = var.rds-secret
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = true
  kms_key_id                          = var.kms_key
  storage_encrypted                   = true
  vpc_security_group_ids              = [var.rds_sg]
  auto_minor_version_upgrade          = false # this will stop the rds instance from automatically upgrading 
  allow_major_version_upgrade         = false

  # Backups are required in order to create a replica
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 1
}

resource "aws_db_instance" "challengedb_read" {
  identifier                          = "challengedbreader"
  replicate_source_db                 = aws_db_instance.default.identifier ## refer to the master instance
  instance_class                      = "db.t3.micro"
  allocated_storage                   = 10
  skip_final_snapshot                 = true
  storage_encrypted                   = true
  vpc_security_group_ids              = [var.rds_sg]
  iam_database_authentication_enabled = true
  # disable backups to create DB faster
  backup_retention_period = 0
}