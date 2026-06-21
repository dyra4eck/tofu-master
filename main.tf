terraform {
	required_providers {
		proxmox = {
			source = "bpg/proxmox"
			version = "~> 0.110"
		}
	}
}

provider "proxmox" {
	endpoint = "https://192.168.122.223:8006/"
	insecure = true
}

resource "proxmox_virtual_environment_container" "first" {
	node_name 	 = "pve" 	# имя узла в ProxmoxVE
	vm_id				 = 110
	unprivileged = true
	
	initialization {
		hostname = "mip-test-git-v16"
		ip_config {
			ipv4 {
				address = "dhcp"
			}
		}
		user_account {
			password = "P@ssw0rd"
			keys		 = [trimspace(file("~/.ssh/id_ed25519.pub"))]
		}
	}

	disk {
		datastore_id = "local-lvm"	# это херня в ProxmoxVE — здесь будет корневая ФС контейнера
		size				 = 4
	}

	network_interface {
		name = "veth0"
	}

	operating_system {
		template_file_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
		type						 = "debian"
	}
}

output "container_ip" {
	value = proxmox_virtual_environment_container.first.ipv4
}
