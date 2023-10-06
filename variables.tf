variable "finding_publishing_frequency" {
  default     = "ONE_HOUR"
  description = "Frequency with which to publish findings (must be one of `FIFTEEN_MINUTES`, `ONE_HOUR`, `SIX_HOURS`)"
  type        = string
}

variable "name" {
  default     = "guard-duty-findings"
  description = "Project name to be used on SNS, GuardDuty, CloudWatch"
  type        = string
}

variable "use_slack_notification" {
  description = "Whether to use Slack notification"
  type        = bool
}

variable "slack_webhook_url" {
  description = "The URL of Slack webhook"
  type        = string
}

variable "slack_channel" {
  description = "The name of the channel in Slack for notifications"
  type        = string
}

variable "slack_emoji" {
  description = "A custom emoji that will appear on Slack messages"
  type        = string
  default     = ":aws:"
}
