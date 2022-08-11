resource "aws_instance" "Bastion_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  vpc_security_group_ids =  [aws_security_group.bastion_host_sg.id]
  key_name = "talent-academy-key-pair"
  subnet_id = data.aws_subnet.public_subnet1.id


  tags = {
    Name = "bastion-host"
  }
}

resource "aws_eip" "bastion_host_eip" {
    instance = aws_instance.Bastion_host.id
    vpc = true
  
}

resource "aws_instance" "elastic_search" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.large"
  vpc_security_group_ids =  [aws_security_group.elastic_search_sg.id]
  key_name = "talent-academy-key-pair"
  subnet_id = data.aws_subnet.private_subnet1.id


  tags = {
    Name = "elastic-search-server"
  }

provisioner "remote-exec" {
  inline = ["echo 'wait untill ssh is ready"]

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/talent-academy-key-pair.pem")
    host = self.private_ip

    bastion_host        = aws_instance.Bastion_host.public_ip
    bastion_private_key = "file(~/.ssh/talent-academy-key-pair.pem)"

  }
}
provisioner "local-exec" {
  command = "ansible-playbook -i {aws_instance.elsatic_search.private_ip}, --private-key {~/.ssh/talent-academy-key-pair.pem} elastic.yml"

}
}