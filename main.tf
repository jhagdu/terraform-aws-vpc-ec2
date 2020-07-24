//Setting Up AWS Provider
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

//Importing VPC Module
module "vpc_module" {
  source = "./vpc"  
}

//Importing EC2 Module
module "ec2_module" {
  source = "./ec2"
  
  wp_ami = var.wordpress
  mysql_ami = var.mysql
  inst_type = var.inst_type
  vpc_id = module.vpc_module.vpc_id
  pub_sn_id = module.vpc_module.pub_sn_id
  pri_sn_id = module.vpc_module.pri_sn_id
}

//Database Host IP 
output "db_host" {
  value = "${module.ec2_module.db_host}"
}

//Open Wordpress Site
resource "null_resource" "open_wp" {
  provisioner "local-exec" {
    command = "start chrome ${module.ec2_module.wp_dns}"
  }
}
