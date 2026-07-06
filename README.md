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
