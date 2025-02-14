resource "aws_elastic_beanstalk_application" "exam_simulator" {
  name        = var.eb_app_name
  description = "ExamSimulator Application"
}

resource "aws_s3_bucket" "eb_app_bucket" {
  bucket = "exam-simulator-artifacts-bucket" # Certifique-se de usar um nome único
}

resource "aws_elastic_beanstalk_application_version" "exam_simulator_version" {
  name        = "v1"
  application = aws_elastic_beanstalk_application.exam_simulator.name
  description = "Initial version of ExamSimulator"
  bucket      = aws_s3_bucket.eb_app_bucket.bucket
  key         = "exam-simulator-v1.zip" # Faça o upload do artefato com esse nome
}

resource "aws_elastic_beanstalk_environment" "exam_simulator_env" {
  name                = var.eb_env_name
  application         = aws_elastic_beanstalk_application.exam_simulator.name
  solution_stack_name = "64bit Amazon Linux 2 v5.4.4 running Corretto 11"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/"
  }

  version_label = aws_elastic_beanstalk_application_version.exam_simulator_version.name
}

# Grupo de segurança para o RDS
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "db_sg" {
  name        = "exam_simulator_db_sg"
  description = "Security group for ExamSimulator RDS instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instância RDS para MySQL
resource "aws_db_instance" "exam_simulator_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "examsimulatordb"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "ExamSimulator DB"
  }
}