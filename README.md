## EC2 to ECS Migration

![](https://img.shields.io/badge/AWS-orange?style=for-the-badge) ![](https://img.shields.io/badge/EC2&ecs-orange?style=for-the-badge) ![Terraform](https://img.shields.io/badge/-Terraform-purple?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/-Docker-blue?style=for-the-badge&logo=docker&logoColor=white)  ![GitHub Actions](https://img.shields.io/badge/-GitHub_Actions-blue?style=for-the-badge&logo=github-actions&logoColor=white)



This project simulates what real cloud migration would look like in a production grade enviornmet. By taking a legacy EC2 application and migrating it to a modernised, containerised ECS Fargate launch type with established networking, Continious Intergration and Continious Deployment, and Observability. Furthermore by Implementing a Cutover plan to document the process between each switch 

## Before EC2 Migration, Architecture Diagram

<p align="center">
    <img src="./images/ec2.png" width=600>


## After EC2 Migration, ECS Architecture Diagram
<p align="center">
    <img src="./images/ecs-architecture.png" width=800 height=900>


## Explanation of ECS Architecture Diagram

- Users Sends traffic through Cloudflare Delegaton and hands over Authoratative access to Route53 in order to look up for Name Servers
- Traffic goes through Route53 Directly into Internet Gateway; which allows VPC to have access to Public Internet
- After Interent Gateway, traffic reaches the ALB, which sits in the public subnet. With Security Group attached to the application load balancer which acts as a firewall only allowing port 80 and port 443 traffic from anywhere. 
- Inside the ALB, It contains Two Listeners which waits for HTTPS and HTTP Traffic while the Target Group distributes traffic tasks depending on which application, for this instance is the ECS with only Port 5002 Configured.
- A seperate security group is attached to the ecs tasks, allowing traffic on port 5002 from ALB security group - making sure that there isn't any exposed access to the internet as it contains heavy senstive confidental information.
- To be able to Pull Images and Continously log information into ECR & Cloudwatch, have private subnets have an outbound rule to public subnet which NAT Gateway, which is used if you want your private subnet to allow access to the internet without having inbound exposure. Since the we need to autonomously have it where ecs is receving the latest Docker image while also keeping in check for Logging Cloudwatch Metrics and viewing them in Dashboard.

- Developer run mutlitple workflows through GitHub Actions. within each workflow, it builds the docker image and provisions the infrastructure via Terraform, alongside Remote terraform.tfstate stored in S3 bucket -> enabling collaboration between other collaborates and peers.

- Monitor Failed ECS Deployments Via AWS EventBridge -> Cloudwatch Logs + Alarms

## Components used

* Cloudflare Provider inbuked in terraform + Using API Token for Automating and Updating Records at the Same time when Deploying Application.
* Docker Mutli Stage Image used for Less storage and Cost effecient -> Quicker runtime for the Image being Built
* Configured OpenID Connect between Github Actions and AWS for short lived credentials and no more static keyes being stored
* Modularised Terraform into 7 modules for Reusability and Organizaton, Consistency and Collaboration
* Switched Legacy EC2 from Amazon Linux to Ubuntu for consistency.


## Full Migration Strategy


For the Full migration strategy, I use the AWS Native Weighted Routing as seen below to be able to shift between the amount of traffic that is directed between two applications, in this instance, I used EC2 and ECS

```
Formula of Weighted Policy


Traffic (%) = Weight for a specific Record 
              -----------------------------
            Sum of all the Weights for all records
```


To function this effectively, and being able to control the amount of traffic between both applications, I've set the amount weight inside ./infra/terraform.tfvars, this is used to control the amount of traffic needed between two applications. 


I've used a Terraform data resource block (./infra/data.tf) to fetch the EC2 Elastic IP from AWS by its legacy-api- tag, allowing the ECS Fargate infrastructure to point its EC2 weighted routing record at the legacy Elastic IP, storing the EIP as a local value which then be used as a record target in Route53.

The reason why i chose weighted routing policy because it's most approachable cutover method compared to all the other approaches avaliable with it combined a low blast radius, only affecting a small to tiny portion of users having access to the site compared to all the other approaches where the blast raidus affects the entire user experience. Being able to control the amount of traffic between EC2 and ECS by adjusting their weights means having a rollback is easy to apply just by changing the weight while fixing the overall issue onto why the ECS is underperforming, failing with the use of CloudWatch and Eventbridge being used as a diagnostic tools, with Route53 health checks providing an additional automatic safety net throughout the process

## CI/CD Explanation

```
 1) Build.yml
 2) Deploy.yml
 3) 
 4)
 5)
```




## Project Structure

```
.
├── Dockerfile
├── README.md
├── bootstrap
│   ├── main.tf
│   └── provider.tf
├── ec2-legacy-app
│   ├── ARCHITECTURE.md
│   ├── QUICKSTART.md
│   ├── README.md
│   ├── app
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   └── wsgi.py
│   ├── nginx
│   │   └── default.conf
│   ├── scripts
│   │   ├── setup.sh
│   │   ├── test-api.sh
│   │   └── validate-setup.sh
│   ├── systemd
│   │   └── app.service
│   ├── terraform
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfstate
│   │   ├── terraform.tfvars
│   │   ├── terraform.tfvars.example
│   │   └── variables.tf
│   └── terraform.tfstate
├── images
│   ├── ec2.png
│   └── ecs-architecture.png
├── infra
│   ├── backend.tf
│   ├── data.tf
│   ├── main.tf
│   ├── modules
│   │   ├── acm
│   │   ├── alb
│   │   ├── cloudwatch
│   │   ├── ecs
│   │   ├── iam
│   │   ├── route53
│   │   ├── security_group
│   │   ├── vpc
│   │   └── vpc-endpoints
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars
│   └── variables.tf
├── terraform.tfstate
└── test
    └── Dockerfile

```


