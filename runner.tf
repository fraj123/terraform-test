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

resource "aws_instance" "runner" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.large"
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = "franz-runner"

  root_block_device {
    volume_size = 50
  }

  tags = {
    Name = "franz-runner"
  }
}
