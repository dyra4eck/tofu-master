output "containers_ip" {
  value = {
    for name, ct in proxmox_virtual_environment_container.this : name => ct.ipv4 # this - это имя
  }
}
