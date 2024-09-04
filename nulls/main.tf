# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

variable "pet" {
  type = string
}

variable "instances" {
  type = number
}

resource "null_resource" "this" {
  count = var.instances

  triggers = {
    pet = var.pet
    always = uuid()
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}

output "ids" {
  value = [for n in null_resource.this: n.id]
}
