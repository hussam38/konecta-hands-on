resource "aws_iam_role" "this" {
  for_each             = var.iam_roles
  name                 = each.value
  max_session_duration = 3600
  assume_role_policy   = file("${path.module}/policies/${each.value}.json")
  tags = endswith(each.value, "-9je9i") ? {
    QuickSetupID      = var.setup_id
    QuickSetupType    = var.setup_type
    QuickSetupVersion = var.setup_version
  } : {}
  tags_all = endswith(each.value, "-9je9i") ? {
    QuickSetupID      = var.setup_id
    QuickSetupType    = var.setup_type
    QuickSetupVersion = var.setup_version
  } : {}
}