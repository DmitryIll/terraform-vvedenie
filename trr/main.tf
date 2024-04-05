variable count_vm {}

variable "vm" {
  type = list(
    object({
      name = string
      image = string
      cpu = number
      core_fraction = number
      ram = number
      disk_size = number
      allow_stopping   = bool
      platform = string
      zone = string
      preemptible = bool
      nat = bool
      cmd = list(string)
    })
  )
  description = "параметры ВМ"
}


# variable hostname_blocks {}
# variable name_bloks {}
# variable images_blocks {}
# variable cores_blocks {}
# variable memory_blocks {}
# variable core_fraction_blocks {}

#---- vms --------------

resource "yandex_compute_instance" "vm" {

  count = "${var.count_vm}"

  name = "${var.vm[count.index].name}" 
  hostname = "${var.vm[count.index].name}" 

  allow_stopping_for_update = "${var.vm[count.index].allow_stopping}"
  platform_id               = "${var.vm[count.index].platform}"
  zone                      = "${var.vm[count.index].zone}"

  resources {
    core_fraction = "${var.vm[count.index].core_fraction}" 
    cores  = "${var.vm[count.index].cpu}" 
    memory = "${var.vm[count.index].ram}"  
  }

  boot_disk {
    initialize_params {
      image_id = "${var.vm[count.index].image}"
      size = "${var.vm[count.index].disk_size}"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}" 
    nat       = "${var.vm[count.index].nat}"
  }

  scheduling_policy {
  preemptible = "${var.vm[count.index].preemptible}"
   }

 metadata = {
    user-data = "${file("./meta.yaml")}" 
  }

#---------- создаем папки -----

  # provisioner "remote-exec" {
  #   inline = [
  #    "cd ~",
  #    "mkdir -pv configs",
  #    "mkdir -pv docker_volumes",
  #    ]
  # }

# #---------- копируем файлы ----

   provisioner "file" {
     source      = "./keys/id_ed25519"
     destination = "/root/.ssh/"
   }


#----------------------------------------------------------

  provisioner "remote-exec" {
    inline = "${var.vm[count.index].cmd}"
  }

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("id_ed25519")}"
      host = self.network_interface[0].nat_ip_address
    }
 
}




/*
resource "yandex_compute_instance" "vm" {

  count = "${var.count_vm}"

  name = "${var.name_bloks[count.index]}" 
  hostname = "${var.hostname_blocks[count.index]}" 

  allow_stopping_for_update = true
  platform_id               = "standard-v1" 
  #zone                      = local.zone

  resources {
    core_fraction = "${var.core_fraction_blocks[count.index]}" 
    cores  = "${var.cores_blocks[count.index]}" 
    memory = "${var.memory_blocks[count.index]}"  
  }

  boot_disk {
    initialize_params {
      image_id = "${var.images_blocks[count.index]}"
      size = 16
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}" 
    nat       = true
  }

  scheduling_policy {
  preemptible = true
   }

 metadata = {
    user-data = "${file("./meta.yaml")}" 
  }

#---------- создаем папки -----

  # provisioner "remote-exec" {
  #   inline = [
  #    "cd ~",
  #    "mkdir -pv configs",
  #    "mkdir -pv docker_volumes",
  #    ]
  # }

# #---------- копируем файлы ----

#   provisioner "file" {
#     source      = "../proxy.yaml"
#     destination = "/root/proxy.yaml"
#   }


#----------------------------------------------------------

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get update",
    "sudo apt-get install -y ca-certificates curl gnupg",
    "sudo install -m 0755 -d /etc/apt/keyrings",
    "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
    "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
    "echo \"deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \"$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable\" |  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
    "sudo apt-get update",
    "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
#    "sudo chmod +x /root/proxy.yaml",
    "apt install -y mariadb-client-core-10.6 ",
    "wget https://hashicorp-releases.yandexcloud.net/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip",
    "apt install -y unzip",
    "unzip terraform_1.5.5_linux_amd64.zip -d /root",
    "mv /root/terraform /bin/trr",
    "trr -v"
    ]
  }
   
   # "git clone https://github.com/DmitryIll/shvirtd-example-python.git"

#    "sudo docker compose up -d"


    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("id_ed25519")}"
      host = self.network_interface[0].nat_ip_address
    }
 
}


*/