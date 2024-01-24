output "CTF_Server_Public_IP" {
    value = aws_instance.ctf-ec2.public_ip
}