output "alb_domain" {
  value = module.public_alb.lb_dns_name
}
