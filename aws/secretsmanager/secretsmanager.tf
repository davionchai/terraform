resource "aws_secretsmanager_secret" "secrets_de_airflow_deployment" {
  description = "Secrets for data engineering airflow deployment"
  name        = "de-airflow-deployment-secrets"
  kms_key_id  = aws_kms_alias.general_de_kms_alias.arn
  tags = {
    Owner       = var.owner_email
    Environment = "playground"
    ManagedBy   = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "secret_de_airflow_deployment_version" {
  secret_id     = aws_secretsmanager_secret.secrets_de_airflow_deployment.id
  secret_string = <<EOF
  {
    "fernet_key": "fernet_key_format",
    "flower_admin_auth": "any_username:any_password",
    "metadata_connection_url": "postgresql://rds_username:rds_password@rds_uri:5432/db_name?sslmode=disable",
    "redis_password": "",
    "broker_connection_url": "redis://:$REDIS_PASSWORD@k8s_redis_deployment_name:6379/0",
    "result_backend_connection_url": "db+postgresql://rds_username:rds_password@rds_uri:5432/db_name",
    "smtp_password": "",
    "webserver_secret_key": "fernet_key_format",
    "webserver_admin_password": "",
  }
  EOF
}
