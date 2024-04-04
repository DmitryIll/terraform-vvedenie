terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=0.13" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {}

# provider "docker" {
#   host     = "ssh://root@158.160.110.79:22"
#   ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
# }

#однострочный комментарий

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx1" {
  image = docker_image.nginx.image_id
  name  = "hello_world"
  #name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}

# --------- Задание 2 ------------------------

# док. провайдера:  https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs
#    Используя terraform и remote docker context, скачайте и запустите на вашей ВМ контейнер mysql:8 на порту 127.0.0.1:3306,
#     передайте ENV-переменные. 
# Сгенерируйте разные пароли через random_password и передайте их в контейнер, 
# используя интерполяцию из примера с nginx.(name  = "example_${random_password.random_string.result}" , двойные кавычки и фигурные скобки обязательны!)

    # environment:
    #   - "MYSQL_ROOT_PASSWORD=${...}"
    #   - MYSQL_DATABASE=wordpress
    #   - MYSQL_USER=wordpress
    #   - "MYSQL_PASSWORD=${...}"
    #   - MYSQL_ROOT_HOST="%"

resource "random_password" "ROOT_PASSWORD" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "MYSQL_PASSWORD" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}
resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql"
  #name  = "example_${random_password.random_string.result}"

  ports {
    internal = 3306
    external = 3306
  }

  env {
    MYSQL_ROOT_PASSWORD = "${random_password.ROOT_PASSWORD.result}"
    MYSQL_DATABASE = "wordpress"
    MYSQL_USER = "wordpress"
    MYSQL_PASSWORD = "${random_password.MYSQL_PASSWORD.result}"
    MYSQL_ROOT_HOST = "%"
  }
}
