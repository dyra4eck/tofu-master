terraform {
	required_providers {
		proxmox = {
			source = "bpg/proxmox"
			version = "~> 0.110"
		}
	}
}

provider "proxmox" {
	endpoint = var.proxmox_endpoint
	insecure = true
}

resource "proxmox_virtual_environment_container" "this" {
	for_each = var.containers	
	node_name 	 = "pve" 	# имя узла в ProxmoxVE
	vm_id				 = each.value.vm_id
	unprivileged = true
	
	initialization {
		hostname = each.value.hostname
		ip_config {
			ipv4 {
				address = "dhcp"
			}
		}
		user_account {
			password = var.root_password
			keys		 = [trimspace(file("~/.ssh/id_ed25519.pub"))]
		}
	}

	disk {
		datastore_id = "local-lvm"	# это херня в ProxmoxVE — здесь будет корневая ФС контейнера
		size				 = each.value.disk_size
	}

	network_interface {
		name = "veth0"
	}

	operating_system {
		template_file_id = each.value.template_file_id
		type						 = each.value.type
	}
}

output "containers_ip" {
	value = {
		for name, ct in proxmox_virtual_environment_container.this : name => ct.ipv4
	}
}

