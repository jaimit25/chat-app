GATEWAY_DIR=api-gateway
IMAGE_NAME=api-gateway/kong:latest
K8S_DIR=$(GATEWAY_DIR)/k8s

.PHONY: api-gateway-build
api-gateway-build:
	@echo "🚀 Building API Gateway Docker image..."
	docker build -t $(IMAGE_NAME) -f $(GATEWAY_DIR)/docker/Dockerfile $(GATEWAY_DIR)

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
