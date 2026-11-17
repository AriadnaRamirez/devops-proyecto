variable "environment" {
  description = "Ambiente de despliegue"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "node_count" {
  description = "Número de nodos del clúster AKS"
  type        = number
  default     = 2
}