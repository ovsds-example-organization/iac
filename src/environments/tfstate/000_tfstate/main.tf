module "tf_state" {
  source = "../../../modules/yc_tfstate/v1"

  cloud_id    = var.yc_cloud_id
  iam_token   = var.yc_iam_token
  bucket_name = "ovsds-example-cloud-tfstate"
}
