count_vm = 2

vm=[
      {name = "vm1"
      image = "fd82nvvtllmimo92uoul"
      cpu = 4
      core_fraction = 100
      ram = 4
      disk_size = 16
      allow_stopping = true
      platform = "standard-v1"
      zone = "ru-central1-a"
      preemptible = true
      nat = true
      cmd =[
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
        "mv /root/terraform /bin/trr"
      ]},

      {name = "vm2"
      image = "fd82nvvtllmimo92uoul"
      cpu = 4
      core_fraction = 100
      ram = 4
      disk_size = 16
      allow_stopping = true
      platform = "standard-v1"
      zone = "ru-central1-a"
      preemptible = true
      nat = true
      cmd =[
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
        "mv /root/terraform /bin/trr"
      ]}
]


/*
hostname_blocks = ["dp", "vm2"]
name_bloks = ["dp", "vm2"]

core_fraction_blocks = ["100", "100"] 
cores_blocks = ["4", "4"] 
memory_blocks = ["4","4"]  

images_blocks = ["fd82nvvtllmimo92uoul","fd82nvvtllmimo92uoul" ]   #ubuntu

*/



