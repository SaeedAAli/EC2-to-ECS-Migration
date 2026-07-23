## EC2 to ECS Migration

![](https://img.shields.io/badge/AWS-orange?style=for-the-badge) ![](https://img.shields.io/badge/EC2&ecs-orange?style=for-the-badge) ![Terraform](https://img.shields.io/badge/-Terraform-purple?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/-Docker-blue?style=for-the-badge&logo=docker&logoColor=white)  ![GitHub Actions](https://img.shields.io/badge/-GitHub_Actions-blue?style=for-the-badge&logo=github-actions&logoColor=white)



This project simulates what real cloud migration would look like in a production grade environment. By taking a legacy EC2 application and migrating it to a modernised, containerised ECS Fargate launch type with established networking, Continious Intergration and Continious Deployment, and Observability. Furthermore by Implementing a Cutover plan to document the process between each switch 

## Before EC2 Migration, Architecture Diagram

<p align="center">
    <img src="./images/ec2.png" width=600>


## After EC2 Migration, ECS Architecture Diagram
<p align="center">
    <img src="./images/ecs-architecture.png" width=800 height=900>


## Explanation of ECS Architecture Diagram

- Users Sends traffic through Cloudflare Delegation and hands over Authoriatative access to Route53 in order to look up for Name Servers
- Traffic goes through Route53 Directly into Internet Gateway; which allows VPC to have access to Public Internet
- After Interent Gateway, traffic reaches the ALB, which sits in the public subnet. With Security Group attached to the application load balancer which acts as a firewall only allowing port 80 and port 443 traffic from anywhere. 
- Inside the ALB, It contains Two Listeners which waits for HTTPS and HTTP Traffic while the Target Group distributes traffic tasks depending on which application, for this instance is the ECS with only Port 5002 Configured.
- A seperate security group is attached to the ecs tasks, allowing traffic on port 5002 from ALB security group - making sure that there isn't any exposed access to the internet as it contains heavy sensitive confidenti al information.
- To be able to Pull Images and Continously log information into ECR & Cloudwatch, private subnets route outbound traffic through a NAT Gateway sitting in the public subnet, this allows resources in the private subnet to reach the internet without being exposed to inbound traffic themselves.Since the we need to autonomously have it where ecs is receving the latest Docker image while also keeping in check for Logging Cloudwatch Metrics and viewing them in Dashboard.

- Developer run mutlitple workflows through GitHub Actions. within each workflow, it builds the docker image and provisions the infrastructure via Terraform, alongside Remote terraform.tfstate stored in S3 bucket -> enabling collaboration between other collaborators and peers.

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

When it comes to CI/CD Explanation, The workflows have been split into 5 separate tasks so that errors are easier to isolate, debugging becomes much more easier by finding which workflows is failing.

Each Worlfows has its unique attribute and how its published to AWS + Cloudflare


 - **Build.yml**:  This workflow creates the Elastic Container Registry through AWS CLI, Build the DockerFile image, Using Trivy as a Security Scanner to avoid any issues and pushes the Image with the latest tag to Elastic Container Registry
 - **Deploy.yml**:  Runs Terraform from `./infra` to deploy and update the ECS Fargate infrastructure in AWS.
 - **Destroy.yml**:  Tears down the ECS Fargate Infrastructure, leaving no active AWS services running to cut down cost
 - **Legacy-terraform.yml**:  Launches the EC2 Legacy application through `ec2-legacy-app/terraform` by creating a VPC, An EC2 Instance, Internet Gateway, NGINX Proxy with Flask Database
 - **Ec2-Tearinfra.yml**:  Crumbles the EC2 Legacy Application once the ECS can handle all the traffic and the rollback plan isnt needed

 For This Project, the **Preconditions used** for it CICD

 - Cloudflare API Key embedded in environments, to tackle the solution of having to manually add Name Servers to Cloudflare Record manually, furthermore, when running the Deploy.yml workflow, it takes 
 - AWS OpenID Connect;  authenticate short lived credentials rather than using static AWS access keys stored as Secrets
 - Use a Security Scanner whether that would be Trivy, Gripe and More
 - Have Environments Created when using workflows rather than having stored as a global repository secret.  Environment Secrets > Global repository secret for security improvement
 - Manually deploy each workflow via Workflow Dispatch


- Used a Backend on both the Legacy Application and Ecs Fargate through terraform via terraform.tfstate, this enables remote collaboration through having it stored in the same  S3 bucket, alongside being able to successfully close down each services through github actions and avoid doing it manually. with each `./infra` and `ec2-legacy-app` have its own seperate key to avoid state collisions between two stacks; and also makes destroying each infrastructure much easier through automation


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
│   └── terraform
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfvars
│       ├── terraform.tfvars.example
│       └── variables.tf
├── images
│   ├── ec2.png
│   └── ecs-architecture.png
├── infra
│   ├── backend.tf
│   ├── data.tf
│   ├── main.tf
│   ├── modules
│   │   ├── acm
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variable.tf
│   │   ├── alb
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── cloudwatch
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ecs
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── iam
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── route53
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── security_group
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── vpc
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── vpc-endpoints
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── test
    └── Dockerfile

```

## Deployments Step

**Requirements** for deployment this project live

- Amazon Web Services - use User account and not Root account + Amazon 
- Terraform Installed
- Dokcer Desktop
- Cloudflare account owned with a domain
- AWS CLI installed

**Legacy Setup**


``` bash
git clone https://github.com/saeedaali/ec2-to-ecs-migration
cd ec2-legacy-app/  #enter the cloned repository through linux command



cd terraform        # change into its terraform folder

terraform init    
terraform validate 
terraform fmt  
terraform apply   # Provisions the infrastructure which creates the VPC, Internet Gateway, NGINX Proxy, and a Flask Database

For Github Actions

# For Automation through GitHub Actions Do this in order 

- Legacy-terraform.yml: Deploys the Legacy EC2 Application Live

- After deploying the legacy and making sure that there isnt a rollback plan needed for, since the ecs can handle all traffic, tear the infrastructure by running
    - Ec2-TearInfra.yml to reduce cost usage.


```

**ECS Fargate Deployment Step**


``` bash

# If you have already cloned the repository from the first step, just skip to the next part or if you haven't

git clone https://github.com/saeedaali/ec2-to-ecs-migration

docker build -t YOUR_IMAGE_NAME . # could be any image name but for this project called it mutlistage


# Get your ECR repository URI from AWS ECR -> create repository -> select the repository -> view push command

docker push 123456789012.dkr.ecr.eu-west-1.amazonaws.com/YOUR_IMAGE_NAME:latest


cd infra
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt
terraform validate
terraform apply         # Only if you do it in your local computer

# ---------------
# For automation via Github Actions deploy these in order

- Build.yml: Create ECR + Build and Scan image with Docker and Trivy, Pushes it to ECR
- Deploy.yml: Initalized and applies the AWS services before the ECS Fargate in this instance, it would be S3
    - Initalized the ECS Fargate, validating it, format checking, and applying the ecs fargate live on AWS through automation
    - Updates the ECS service which allows it to pick up the latest Docker Image available.

- Destroy.yml: Tears down the entire ECS Fargate infrastructure using 'terraform destroy', referencing the current state stored in the S3 backend

Additional info: Used a conditional to check whether the s3 bucket exists, if it doesnt exist creates the bootstrap if it does exist, skip
```


## Traffic Cutover Plan






















## Rollback Plan


















# Screenshots


