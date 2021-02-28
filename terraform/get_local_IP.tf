data "http" "my_public_ip" {
  url = "https://api.ipify.org/?format=json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  my_public_ip_json = jsondecode(data.http.my_public_ip.body)
}

output "my_ip_addr" {
  value = local.my_public_ip_json.ip
}
