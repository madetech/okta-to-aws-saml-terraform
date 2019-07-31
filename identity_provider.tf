resource "aws_iam_saml_provider" "okta" {
  name                   = module.okta_label.id
  saml_metadata_document = file("SAML.xml")
}

resource "aws_iam_role" "saml" {
  name               = module.okta_label.id
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_saml_provider.okta.arn}"
      },
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role = aws_iam_role.saml.name
}

output "identity-provider-arn" {
  value = aws_iam_saml_provider.okta.arn
}

output "iam-role-name" {
  value = aws_iam_role.saml.name
}
