data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "runner_eni" {
  subnet_id   = module.vpc.public_subnets[0]
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "runner" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.medium"
  associate_public_ip_address = true
  key_name                    = "franz-runner"

  network_interface {
    network_interface_id = aws_network_interface.runner_eni.id
    device_index = 0
  }

  root_block_device {
    volume_size = 50
  }

  tags = {
    Name = "franz-runner"
  }
}
