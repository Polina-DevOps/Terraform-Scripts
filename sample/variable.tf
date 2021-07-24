output "SAMPLE-OUT" {
  value    = "Hello World"
}

variable "SAMPLE-VAR" {
  default  = "First Variable"
}
output "SAMPLE-VAR" {
  value   = var.SAMPLE-VAR
}


variable "TRAINING" {
  default = "AWS"
}

variable "TRAININGS" {
  default = [ "AWS", "DevOps"]
}

variable "TRAINING-DATA" {
  default = {
    AWS = "8AM SGT"
    DevOPS = "10AM SGT"
  }
}

output "TRAINING" {
  value = var.TRAINING
}

output "FIRSTTRAINING" {
  value = "My 1st Training is - ${var.TRAININGS[0]}"
}

output "SECTRAINING" {
  value = "My 2nd Training is - ${var.TRAININGS[1]}"
}

output "TRAINING-DATA" {
  value = "AWS training is on - ${var.TRAINING-DATA["AWS"]}"
}