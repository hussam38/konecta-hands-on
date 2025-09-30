locals {
  default_tags = {
    Country       = var.country
    Platform      = var.platform
    Project       = var.project
    aws-backup-14 = "yes"
  }
  bucket_tags = {
    "stackset-stacksetcloudtrailwitchcloud-trailbucket-ezbak0z3gbtd" = { Platform = "Cloudformation" }
    "s3-restore-fidelidad"                                           = {}
    "restore-lavanguardia-drive-produccion-konecta"                  = {}
    "cf-templates-1r5e4ovoteh3v-us-east-1"                           = {}
    "bsch-bsredes-drive-produccion-konecta" = {
      Country  = var.country,
      Platform = var.platform,
      Project  = var.project,
      Name     = "bsch-bsredes-drive-produccion-konecta",
    }
    "bsch-bsttb-drive-produccion-konecta" = {
      Country  = var.country,
      Platform = var.platform,
      Project  = var.project,
      Name     = "bsch-bsttb-drive-produccion-konecta",
    }
  }
}

resource "aws_s3_bucket" "this" {
  for_each = toset(var.bucket_names)
  bucket   = each.key
  tags = (
    contains(keys(local.bucket_tags), each.key) ?
    local.bucket_tags[each.key] :
    merge(
      local.default_tags,
      { Name = each.key },
    )
  )
  tags_all = (
    contains(keys(local.bucket_tags), each.key) ?
    local.bucket_tags[each.key] :
    merge(
      local.default_tags,
      { Name = each.key },
  ))
}
