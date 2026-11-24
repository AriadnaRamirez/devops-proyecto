variable "environment" {
  type        = string
  description = "Ambiente: dev, staging o prod"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Region de Azure"
  default     = "northcentralus"
}

variable "node_count" {
  type        = number
  description = "Numero de nodos del AKS"
  default     = 2
}

variable "vm_size" {
  type        = string
  description = "Tamano de la maquina virtual del AKS"
  default     = "Standard_b2s_v2"
}
