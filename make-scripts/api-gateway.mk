GATEWAY_DIR=api-gateway
K8S_DIR=api-gateway/k8s

.PHONY: api-gateway-build
api-gateway-build:
	@echo "🚀 Building API Gateway Docker image..."
	docker build -t api-gateway/kong:v1 -f api-gateway/docker/Dockerfile api-gateway

.PHONY: api-gateway-deploy
api-gateway-deploy:
	@echo "☸️ Deploying API Gateway to Kubernetes..."
	kubectl apply -f api-gateway/k8s/api-gateway-configmap.yaml
	kubectl apply -f api-gateway/k8s/api-gateway-deployment.yaml
	kubectl apply -f api-gateway/k8s/api-gateway-service.yaml

.PHONY: api-gateway-delete
api-gateway-delete:
	@echo "🗑️ Deleting API Gateway..."
	kubectl delete -f api-gateway/k8s/api-gateway-service.yaml
	kubectl delete -f api-gateway/k8s/api-gateway-deployment.yaml
	kubectl delete -f api-gateway/k8s/api-gateway-configmap.yaml
