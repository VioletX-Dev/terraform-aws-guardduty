##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Enable AWS Guard Duty on AWS account
##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_guardduty_detector" "this" {
  enable                       = true
  finding_publishing_frequency = var.finding_publishing_frequency
  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = var.has_kubernetes
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }
  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}

##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## CloudWatch event rule for trigger SNS notification
##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "this" {
  name        = var.name
  description = "Event rule for trigger SNS topic from AWS Guard duty"
  event_pattern = jsonencode(
    {
      "source" : ["aws.guardduty"],
      "detail-type" : ["GuardDuty Finding"]
    }
  )
  tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "SendToSNS"
  arn       = module.notify_slack.slack_topic_arn
  input_transformer {
    input_paths = {
      severity            = "$.detail.severity",
      Finding_ID          = "$.detail.id",
      Finding_Type        = "$.detail.type",
      region              = "$.region",
      Finding_description = "$.detail.description"
    }
    input_template = "\"You have a severity <severity> GuardDuty finding type <Finding_Type> in the <region> region.\"\n \"Finding Description:\" \"<Finding_description>. \"\n \"For more details open the GuardDuty console at https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?search=id%3D<Finding_ID>\""
  }
}

##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## SNS Topic and AWS Lambda to send notification to customer's Slack Channels via Incoming Webhook
##------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 5.0"

  create = var.use_slack_notification

  sns_topic_name = var.name

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = "reporter"

    tags = {
    developed = "VioletX.com"
    terraform = "true"
  }
}
