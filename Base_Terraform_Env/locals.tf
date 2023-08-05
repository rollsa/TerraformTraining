locals {
  common_tags = {
    company = var.company
    project = "${var.company}-${var.project}"
    billing = var.billing
    env = var.env
  }

}