resource "yandex_vpc_security_group" "sg-web" {
  name        = "sg-web"
  network_id  = yandex_vpc_network.network.id
  
  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
  
  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
  
  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "MySQL из внешних сетей"
    v4_cidr_blocks = ["0.0.0.0/0"] 
    port           = 3306
  }
  
  egress {
    protocol       = "ANY"
    description    = "Outgoing"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
