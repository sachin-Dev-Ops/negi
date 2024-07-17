resource "aws_security_group" "web_sg" {
  name        = "squizify-${var.env}-web-sg"
  description = "Web EC2 instances"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "web_ingress_80_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = var.alb_sg_id
  description              = "Allow access to port 80 from ALB"
}

resource "aws_security_group_rule" "web_ingress_443_alb" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = var.alb_sg_id
  description              = "Allow access to port 443 from ALB"
}

resource "aws_security_group_rule" "web_ingress_8880_alb" {
  type                     = "ingress"
  from_port                = 8880
  to_port                  = 8880
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = var.alb_sg_id
  description              = "Allow access to port 8880 from ALB"
}

resource "aws_security_group_rule" "web_ingress_8443_alb" {
  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = var.alb_sg_id
  description              = "Allow access to port 8443 from ALB"
}

resource "aws_security_group_rule" "web_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow outbound traffic to any IP address and ports"
}

resource "aws_security_group" "cron_sg" {
  name        = "squizify-${var.env}-cron-sg"
  description = "Cron EC2 instances"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "cron_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cron_sg.id
  description       = "Allow outbound traffic to any IP address and ports"
}
