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

   #"MYSQL_ROOT_PASSWORD = ${random_password.ROOT_PASSWORD.result}",

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql"

  env = ["MYSQL_ROOT_PASSWORD=123", "MYSQL_DATABASE=\"wordpress\"", "MYSQL_USER=\"wordpress\""  ]

    # - "MYSQL_PASSWORD=123"
    # - "MYSQL_ROOT_HOST=123" 

  # env = [
  #   #- "MYSQL_ROOT_PASSWORD=${ random_password.ROOT_PASSWORD.result }"
  #   # - "MYSQL_DATABASE=wordpress"
  #   # - "MYSQL_USER=wordpress"
  #   # - "MYSQL_PASSWORD=${random_password.MYSQL_PASSWORD.result}",
  #   # - "MYSQL_ROOT_HOST=\"%\"" 
  #   ]


  ports {
    internal = 3306
    external = 3306
  }
}

#----------------

/*

resource "docker_image" "mysql" {
  name = "mysql:8"
}
resource "random_password" "mysql_root_password" {
  length = 16
}
resource "docker_container" "mysql" {
  name = "mysql"
  image = "${docker_image.mysql.image_id}"
  env {
    MYSQL_ROOT_PASSWORD = "${random_password.mysql_root_password.result}"
  }
  mounts {
    source = "/some/host/mysql/data/path"
    target = "/var/lib/mysql/data"
    type = "bind"
  }
  ports {
    internal = 3306
    external = 3306
  }
}

*/