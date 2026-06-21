variable "proxmox_endpoint" {
	type = string
	description = "Адрес API Proxmox"
}

variable "root_password" {
	type = string
	sensitive = true
	description = "Пароль root от контейнера"
}

variable "vm_id_mip-test-git-v16" {
	type = number
	default = 110
	description = "ID контейнера mip-test-git-v16"
}
