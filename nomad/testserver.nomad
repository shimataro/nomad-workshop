job "testjob" {
  meta {
    uuid = uuidv4()
  }

  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "testgroup" {
    count = 2
    network {
      port "web" {
        to = 3000
      }
    }

    service {
      name = "testserver"
      tags = ["global"]
      port = "web"

      check {
        name     = "alive"
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "testtask" {
      driver = "docker"

      config {
        image = "ghcr.io/shimataro/nomad-workshop/testserver:latest"
        ports = ["web"]

        auth {
          username = "<GitHub username>"
          password = "<personal access token>"
        }
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }
    }
  }
}
