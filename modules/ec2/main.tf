# Data block to filter ami based on region ( as ami id for each region is different )
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Canonical
}

# Resource block to created aws ec2 instance
resource "aws_instance" "this" {
  ami           = var.override_ami_id != "" ? var.override_ami_id : data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  #   key_name               = var.key_name // we can add this if want to attach keys from aws
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  disable_api_termination = var.ec2_termination_protection
  disable_api_stop        = var.ec2_stop_protection

  # Using this format we are informing terraform to merge all tags from variable tags and the tag provided here
  tags = var.tags

  # Specify the root EBS volume
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_ebs_volume_size # specify your desired size in GB
    delete_on_termination = true
    tags                  = var.root_block_device_tags
  }

  # Attach an additional EBS volume
  dynamic "ebs_block_device" {
    for_each = var.include_additional_volume ? [1] : []
    content {
      device_name           = "/dev/sdh" # specify the desired name
      volume_type           = "gp3"
      volume_size           = var.additional_ebs_volume # specify your desired size in GB
      delete_on_termination = true
    }
  }

  lifecycle {
    ignore_changes = [user_data]
  }

  # Include the user script from a file
  user_data = var.user_data != "" ? file(var.user_data) : null
}
