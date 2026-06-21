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

resource "proxmox_virtual_environment_container" "first" {
	node_name 	 = "pve" 	# имя узла в ProxmoxVE
	vm_id				 = var.vm_id_mip-test-git-v16
	unprivileged = true
	
	initialization {
		hostname = var.hostname_first
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
		size				 = var.disk_size_first
	}

	network_interface {
		name = "veth0"
	}

	operating_system {
		template_file_id = var.os_template_file_id_first
		type						 = var.os_type_first
	}
}

output "container_ip" {
	value = proxmox_virtual_environment_container.first.ipv4
}
