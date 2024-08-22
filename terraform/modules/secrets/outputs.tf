output "openai_api_key_arn" {
  value = data.aws_ssm_parameter.openai_api_key.arn
}

output "acled_api_key_arn" {
  value = data.aws_ssm_parameter.acled_api_key.arn
}

output "cpaor_email_arn" {
  value = data.aws_ssm_parameter.cpaor_email.arn
}

output "acaps_password_arn" {
  value = data.aws_ssm_parameter.acaps_password.arn
}

output "streamlit_password_arn" {
  value = data.aws_ssm_parameter.streamlit_pwd.arn
}