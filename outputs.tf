output "k3s_ec2_public_dns" {
  value       = module.ec2_instance.public_dns
  description = "The public DNS of the instance"
}

output "k3s_ec2_public_ipv4" {
  value       = module.ec2_instance.public_ip
  description = "The public IPv4 of the instance"
}
