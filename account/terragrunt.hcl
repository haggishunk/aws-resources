# store state locally
# inputs
#   root creds
# outputs
#   admin user
#   admin role
#   admin s3 bucket
terraform {
    backend "local" {
        path = "."
    }
    
    source = "${}"

    # is this necessary or desired for boot?
    # include {
    #     path = find_in_parent_folders()
    # }
}

inputs {
    root_account_id = "<insert-acct-id>"
    admin_pgp_key = "keybase:<some-person>"
}
