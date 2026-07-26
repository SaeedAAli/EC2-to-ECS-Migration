## Vpc Vars
vpc_cidr        = "10.0.0.0/16"
public_subnet1  = "10.0.1.0/24"
public_subnet2  = "10.0.3.0/24"
private_subnet1 = "10.0.4.0/24"
private_subnet2 = "10.0.2.0/24"

## ------------------------------------
## Security Group TF.Vars

## Ecs Vars
family                  = "app"
network_mode            = "awsvpc"
require_compatibilities = ["FARGATE"]
cpu                     = "256"
memory                  = "512"
name                    = "Cluster"
image                   = "923673751050.dkr.ecr.eu-west-2.amazonaws.com/ec2toecsdckfile"


#------------------------------------------------------------------------
# Application Load Balancer Values
load_balancer_type = "application"
ALBname            = "ALB"
internal           = false

#---------------
# Target Group
Target_group_name = "Load Balancer"
Target_port       = 5002
Target_Protocol   = "HTTP"
Target_type       = "ip"

# ---
#Route53
subdomain = "ec2toecsmigration.saeedaali.uk"

# -- Cloudflare
zone_id = "21ce3d9268eef1589ab131eeee25b103"

# ------
# Cutover Weighted Routing
ec2_eip    = ""
ecs_weight = 90
ec2_weight = 10
ttl        = 60