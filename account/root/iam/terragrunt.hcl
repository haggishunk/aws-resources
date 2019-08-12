# store state in s3 bucket
# inputs
#   admin role
# outputs
#   iam users
#   iam roles
#   iam policies
#   env roles
#   env s3 buckets
terraform {
    remote_state {
        backend = "s3"
        config = {
            bucket = "${var.env}-something-unique"
            key = "${path_relative_to_include()}/terraform.tfstate"
            region = "${var.backend_region}"
            encrypt = true
            dynamocb_table = "${var.db_name}"
    source = "${}"

    include {
        path = find_in_parent_folders()
    }
}

inputs {}
