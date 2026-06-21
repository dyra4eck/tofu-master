variable "proxmox_endpoint" {
	type = string
	description = "Адрес API Proxmox"
}

variable "root_password" {
	type = string
	sensitive = true
	description = "Пароль root от контейнера"
}

# ---- first -----------------------------------
variable "vm_id_mip-test-git-v16" {
	type = number
	default = 110
	description = "ID контейнера mip-test-git-v16"
}

variable "hostname_first" {
	type = string
	description = "Имя хоста"
}

variable "disk_size_first" {
	type = number
	description = "Размер дискового пространства"
}

variable "os_type_first" {
	type = string
	description = "Тип ОС"
}

variable "os_template_file_id_first" {
	type = string
	description = "Используемый образ"
}
