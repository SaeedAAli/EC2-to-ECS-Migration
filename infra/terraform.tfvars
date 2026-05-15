## Vpc Vars
vpc_cidr = "10.0.0.0/16"
public_subnet1 = "10.0.1.0/24"
public_subnet2 = "10.0.3.0/24"
private_subnet1 = "10.0.4.0/24"
private_subnet2 = "10.0.2.0/24"

## ------------------------------------
## Security Group TF.Vars



## Ecs Vars
family = "app"
network_mode = "awsvpc"
require_compatibilities = ["FARGATE"]
cpu = "256"
memory = "512"
execution_role_arn = module.iam.ecs_task
name = "Cluster"
image = "923673751050.dkr.ecr.eu-west-2.amazonaws.com/ec2toecsmigration"


#------------------------------------------------------------------------
# Application Load Balancer Values
load_balancer_type = "application"
ALBname = "ALB"
internal = false
subents1 = module.vpc.PublicSubnet1
subnets2 = module.vpc.PublicSubnet2
security_group = aws_security_group.lb_sg