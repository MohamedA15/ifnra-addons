module "argocd" {
  source = "./modules/argocd"
}

module "ingress_nginx" {
  source = "./modules/ingress-nginx"
}

module "cert_manager" {
  source = "./modules/cert-manager"
}