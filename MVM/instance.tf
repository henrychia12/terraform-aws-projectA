resource "aws_instance" "ui" {
  # ubuntu 18.04
  ami = "ami-0c30afcb7ab02233d"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.ui.id}"
  vpc_security_group_ids = ["${aws_security_group.ui.id}"]
  associate_public_ip_address = true
  key_name = "default-key-pair"
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = "${self.public_ip}"
      user = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
	     	"sudo apt-get install git",
		"git clone http://github.com/HMSBennett/DockerInstall",			
		"cd DockerInstall",
		"./install.sh",
		"./docCompInstall.sh",
		"cd ..",
		"git clone https://github.com/HMSBennett/DockerMEAN",
		"cd DockerMEAN",
		"cd OneVM",
		"sudo systemctl enable docker",
		"sudo systemctl start docker",
		"sudo docker-compose up -d"
    ]
  }
}

resource "aws_instance" "api" {
  # ubuntu 18.04
  ami = "ami-0c30afcb7ab02233d"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.api.id}"
  vpc_security_group_ids = ["${aws_security_group.api.id}"]
  associate_public_ip_address = true
  key_name = "default-key-pair"
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = "${self.public_ip}"
      user = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
	      "echo testing api"    
	     ]
  }
}

resource "aws_instance" "db" {
  # ubuntu 18.04
  ami = "ami-0c30afcb7ab02233d"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.db.id}"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  associate_public_ip_address = true
  key_name = "default-key-pair"
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = "${self.public_ip}"
      user = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
	      "echo testing db"    
	     ]
  }
}

