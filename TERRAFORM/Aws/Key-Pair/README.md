

**EC2 key pair:**

A key pair is used to control login access to EC2 instances. It requires an existing user-supplied key pair.

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/Users/bonny/.ssh/id_rsa.pub")
}