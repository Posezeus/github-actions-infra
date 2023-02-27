output "alb-tg-arn" {
  value = aws_lb_target_group.demo-target-group.arn
}
output "alb-dns" {
  value = aws_lb.demo-alb.dns_name
}
output "alb-zone-id" {
  value = aws_lb.demo-alb.zone_id
}