variable "environment" {}

variable "aws_region" {}
variable "aws_profile" {}

# vpc
variable "cidr_block" {}
variable "availability_zones" {}

# ecs
variable "streamlit_app_image" {}
variable "streamlit_app_port" {}
variable "streamlit_fargate_cpu" {}
variable "streamlit_fargate_memory" {}

variable "data_processing_app_image" {}
variable "data_processing_fargate_cpu" {}
variable "data_processing_fargate_memory" {}

# ecs role
variable "streamlit_ecs_task_execution_role" {}
variable "streamlit_ecs_task_role" {}

variable "dp_ecs_task_execution_role" {}
variable "dp_ecs_task_role" {}
