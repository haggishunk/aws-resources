variable "root_account_id" {}
variable "admin_pgp_key" {
  default = "keybase:some_admin_person_that_exists"
}

# you'll want to create a user
# get their access key (but keep it secret)
# create a role with the admin policy
# and associate that user with that role

provider "aws" {}

resource "aws_iam_user" "admin_user" {
  user    = "admin"
}

resource "aws_iam_access_key" "admin_pgp_key" {
  user = "${aws_iam_user.admin_user.name}"
  pgp_key = "${var.admin_pgp_key}"
}

resource "aws_iam_group" "admin_group" {
  name = "admin_group"
}

resource "aws_iam_user_group_membership" "admin_in_admin_group" {
  user   = "${aws_iam_user.admin_user.name}"

  groups = [
    "${aws_iam_group.admin_group.name}",
  ]
}

data "aws_iam_role" "admin_role" {
  name = "admin"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.root_account_id}:group/admin",
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags   = {
    Name =  "admin-role"
  }
}

output "user_name" {
  value = "${aws_iam_user.admin_user.user}"
}

output "user_id" {
  value = "${aws_iam_user.admin_user.id}"
}
output "user_secret_encrypted" {
  value = "${aws_iam_access_key.admin_pgp_key.encrypted_secret}"
}

