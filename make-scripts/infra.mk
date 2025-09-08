# infra/make-scripts/infra.mk

NAMESPACE=chat-infra

# Full infra
.PHONY: infra-create
infra-create:
	@echo "☸️ Creating chat app infra..."
	kubectl apply -f infra/k8s/namespace.yaml
	# kubectl apply -f infra/k8s/redis-deployment.yaml
	# kubectl apply -f infra/k8s/kafka-deployment.yaml
	# kubectl apply -f infra/k8s/postgres-deployment.yaml
	# kubectl apply -f infra/k8s/mongodb-deployment.yaml
	# kubectl apply -f infra/k8s/vault-deployment.yaml
	# kubectl apply -f infra/k8s/consul-deployment.yaml
	# kubectl apply -f infra/k8s/elasticsearch-deployment.yaml
	@echo "✅ Infra created"

.PHONY: infra-down
infra-down:
	@echo "🧹 Deleting chat app infra..."
	kubectl delete namespace $(NAMESPACE) --ignore-not-found
	@echo "✅ Infra deleted"

# Single service operations
SERVICES=redis kafka postgres mongodb vault consul elasticsearch

define MAKE_SINGLE_SERVICE
.PHONY: $1-up $1-down $1-restart
$1-up:
	@echo "☸️ Starting $1..."
	kubectl apply -f infra/k8s/$1-deployment.yaml

$1-down:
	@echo "🧹 Stopping $1..."
	kubectl delete -f infra/k8s/$1-deployment.yaml --ignore-not-found

$1-restart: $1-down $1-up
	@echo "🔄 Restarted $1..."
endef

$(foreach svc,$(SERVICES),$(eval $(call MAKE_SINGLE_SERVICE,$(svc))))
