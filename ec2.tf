// ec2 instance

resource "aws_instance" "server" {
    ami = "ami-045269a1f5c90a6a0"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public2.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name = aws_key_pair.key1.key_name
    user_data = file ("setup.sh")
    tags = {
      Name = "terraform-proj-server"
      env = "dev"
    }
}

// ebs volume

resource "aws_ebs_volume" "ebs" {
  availability_zone = aws_instance.server.availability_zone
  size              = 20

  tags = {
    Name = "Extra-volume"
  }
}

resource "aws_volume_attachment" "atta" {
  instance_id = aws_instance.server.id 
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.ebs.id
  
}