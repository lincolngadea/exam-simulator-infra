output "eb_application_name" {
  value = aws_elastic_beanstalk_application.exam_simulator.name
}

output "eb_environment_url" {
  value = aws_elastic_beanstalk_environment.exam_simulator_env.endpoint_url
}