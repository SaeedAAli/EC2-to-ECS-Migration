output "CLU_ARN"{
value = aws_ecs_cluster.cluster.arn
}
  
output "Name" {
  value = aws_ecs_cluster.cluster.name
}
