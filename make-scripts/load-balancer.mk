.PHONY: load-balancer-build
load-balancer-build:
	@echo "🚀 Building Docker image for Load Balancer..."
	docker build -t load-balancer/lb-nginx:v1 -f load-balancer/docker/Dockerfile load-balancer

.PHONY: load-balancer-deploy
load-balancer-deploy:
	@echo "☸️ Deploying Load Balancer to Kubernetes..."
	kubectl apply -f load-balancer/k8s/load-balancer-deployment.yaml
	kubectl apply -f load-balancer/k8s/load-balancer-service.yaml

.PHONY: load-balancer-delete
load-balancer-delete:
	@echo "🗑️ Deleting Load Balancer from Kubernetes..."
	kubectl delete -f load-balancer/k8s/load-balancer-deployment.yaml --ignore-not-found
	kubectl delete -f load-balancer/k8s/load-balancer-service.yaml --ignore-not-found