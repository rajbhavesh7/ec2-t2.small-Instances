resource "aws_instance" "task" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  count = 3

# Public Subnet assign to instance
  subnet_id     = aws_subnet.public_1.id

# Security group assign to instance
  vpc_security_group_ids=[aws_security_group.allow_ssh.id]

# key name
key_name = var.key_name

  tags = {
    Name = "task"
  }
}