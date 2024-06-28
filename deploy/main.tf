variable "salas_key" {
  type    = string
  default = ""
}

# resource "terraform_data" "ssh_test" {
#   connection {
#     host        = "salas"
#     private_key = local.key
#     user        = "acrease"
#   }
#   provisioner "remote-exec" {
#     inline = ["touch test"]
#   }
# }

resource "terraform_data" "config_repo" {
  connection {
    host        = "salas"
    private_key = try(file("~/.ssh/salas"), file("${path.root}/salas_key"))
    user        = "acrease"
  }
  provisioner "remote-exec" {
    when   = create
    inline = ["git clone https://github.com/apollo-xiv/homelab config"]
  }

  provisioner "remote-exec" {
    when   = destroy
    inline = ["rm -rf config"]
  }
}

resource "null_resource" "update" {
  connection {
    host        = "salas"
    private_key = try(file("~/.ssh/salas"), file("${path.root}/salas_key"))
    user        = "root"
  }
  provisioner "remote-exec" {
    inline = [
      "git -C ~/config pull",                     // pull the latest config
      "nixos-rebuild test --flake ~/config#salas" // sudo nixos update
    ]
  }
  depends_on = [terraform_data.config_repo]
}
