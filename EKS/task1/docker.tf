terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  registry_auth {
    address  = "registry-1.docker.io"
    username = "xxxxxxxxxxx"
    password = "xxxxxxxxxxx"
    #config_file = pathexpand("~/.docker/config.json")     ##Alternative
    }
}

resource "docker_image" "hello_world" {
  name          = "registry-1.docker.io/xxxxxxxxx/hello-world-app"
  build {
    context = "."
    label = {
      author : "xxxxxxxx"
    }
  }
  triggers = {
    #dir_sha1 = sha1(join("", [for f in fileset(path.module, "./*") : filesha1(f)]))
    app_sha1 = sha1(file("./app.py"))
  }
}

resource "docker_registry_image" "push_hello_world" {
  name = docker_image.hello_world.name
  triggers = {
    #dir_sha1 = sha1(join("", [for f in fileset(path.module, "./*") : filesha1(f)]))
    app_sha1 = sha1(file("./app.py"))
  }
}


# Hacky workaround
# resource "null_resource" "push_hello_world" {
#   triggers = {
#     image_id = docker_image.hello_world.image_id
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#     docker login -u "advait124" -p "@Dvait124"
#     docker push ${docker_image.hello_world.name}
# EOT
#   }
# }