module "example" {
  source = "../"

  name                         = "guard-duty-findings-ACME"
  finding_publishing_frequency = "ONE_HOUR"

  use_slack_notification = true
  slack_webhook_url      = "https://hooks.slack.com/services/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"
  slack_channel          = "test-changes-devops"
  slack_username         = "reporter"
}
