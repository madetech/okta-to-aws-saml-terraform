
resource "aws_iam_user" "okta_api" {
  name = module.okta_label.id
  tags = "module.okta_label.tags"
}

data "aws_iam_policy_document" "assume-saml-role" {
  statement {
    effect = "Allow"
    actions = [
      "iam:ListRoles",
      "iam:ListAccountAliases"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = module.okta_label.id
  description = "A test policy"
  policy      = data.aws_iam_policy_document.assume-saml-role.json
}

resource "aws_iam_user_policy_attachment" "saml" {
  user       = aws_iam_user.okta_api.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_access_key" "okta" {
  user = aws_iam_user.okta_api.name
}

output "access-key" {
  value = aws_iam_access_key.okta.id
}

output "secret-key" {
  value = aws_iam_access_key.okta.secret
}

