customer_prefix = "squizify"
primary_region  = "ap-southeast-2"
env             = "staging"

alb_sg_id             = "sg-082eee7d9568554cb"
web_ami_id            = "ami-03a2f531e34ce2574"
web_instance_type     = "t3.xlarge"
cron_ami_id           = "ami-0b4261dff2981c20a"
cron_01_instance_type = "t3.xlarge"
cron_02_instance_type = "t3.medium"
web_target_groups     = ["arn:aws:elasticloadbalancing:ap-southeast-2:211125306867:targetgroup/testing-staging-tg/7bc5875b2cf04880"]
