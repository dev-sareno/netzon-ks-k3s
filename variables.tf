variable "ssh_public_key_base64" {
  type        = string
  description = "The public key that will be added to EC2's `~/.ssh/authorized_keys`"
}
