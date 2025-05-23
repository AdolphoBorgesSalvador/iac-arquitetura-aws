resource "aws_launch_template" "app" {
  name_prefix   = "app-template-"
  image_id = "ami-051f7e7f6c2f40dc1"
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.public_a.id # substituído em autoscaling
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo "Hello from EC2" > index.html
nohup python -m SimpleHTTPServer 80 &
EOF
  )
}
