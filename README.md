## AWS GuardDuty sending notifications to Slack Terraform module

This module enables AWS Guard Duty, creates an SNS topic to receive Guard Duty messages and an AWS Lambda function that sends notifications to Slack using the incoming webhooks API.

Start by setting up an incoming webhook integration in your Slack workspace.
## Usage:

```
module "example" {
  source = "github.com/VioletX-Dev/terraform-aws-guardduty.git?ref=main"

  name                         = "guard-duty-findings-ACME"
  finding_publishing_frequency = "ONE_HOUR"

  use_slack_notification = true
  slack_webhook_url      = "https://hooks.slack.com/services/TEDCADF/BADBKJSDF6ERW4/akjshdaksjhdaksjhdakjshd"
  slack_channel          = "test-changes-devops"
  slack_username         = "reporter"
}
```


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.4.6 |
| aws | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| finding\_publishing\_frequency | Frequency with which to publish findings (must be one of `FIFTEEN_MINUTES`, `ONE_HOUR`, `SIX_HOURS`) | `string` | `"ONE_HOUR"` | no |
| name | Project name to be used on SNS, GuardDuty, CloudWatch | `string` | `"guard-duty-findings"` | no |
| slack\_channel | The name of the channel in Slack for notifications | `string` | n/a | yes |
| slack\_emoji | A custom emoji that will appear on Slack messages | `string` | `":aws:"` | no |
| slack\_webhook\_url | The URL of Slack webhook | `string` | n/a | yes |
| use\_slack\_notification | Whether to use Slack notification | `bool` | n/a | yes |

## Outputs

No output.
