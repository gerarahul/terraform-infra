# resource "aws_key_pair" "public_key" {
#   key_name   = "${var.key_pair_name}"
#   public_key = file("${var.full_path_of_public_key}")

#   tags = {
#     Name = "${var.key_pair_name}"
#   }
# }

# output "public_key" {
#   value     = aws_key_pair.public_key.public_key
#   sensitive = true
# }
