variable "proxmox_endpoint" {
	type = string
	description = "Адрес API Proxmox"
}

variable "root_password" {
	type = string
	sensitive = true
	description = "Пароль root от контейнера"
}

variable "containers" {
	type = map(object({
		vm_id		 				 = number
		hostname 				 = string
		disk_size				 = number
		template_file_id = string
		type 						 = string
	}))
}
