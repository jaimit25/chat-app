include make-scripts/load-balancer.mk
include make-scripts/api-gateway.mk
include make-scripts/infra.mk
include make-scripts/namespace.mk
include make-scripts/user-service.mk

docker.build: 
	@set -e; \
	$(MAKE) api-gateway-build; \
	$(MAKE) load-balancer-build; \
	$(MAKE) user-service-build


up:
	@set -e; \
	$(MAKE) infra-create; \
	$(MAKE) load-balancer-deploy; \
	$(MAKE) api-gateway-deploy; \
	$(MAKE) user-service-deploy; \
	echo "🚀 All services and infra are up!"

down:
	@echo "🧹 Deleting chat app infra..."
	@kubectl delete namespace chat-infra --ignore-not-found
	@kubectl delete namespace chat-app --ignore-not-found
	@echo "✅ All services and infra are down!"

# Used to explain AI about project structure while writing this project
STRUCT_FILE := project-structure.txt

.PHONY: ps
ps:
	@echo "📝 Generating project structure..."
	@rm -f $(STRUCT_FILE)
	@bash ./proj.sh > $(STRUCT_FILE)
	@echo "✅ Project structure saved to $(STRUCT_FILE)"
	@code project-structure.txt

.PHONY: cs
cs:
	@echo "🧹 Cleaning project structure file..."
	@rm -f $(STRUCT_FILE)
	@echo "✅ Deleted $(STRUCT_FILE)"

.PHONY: create
create:
	@echo "📝 Generating project structure..."	
	@bash ./create-service.sh > $(STRUCT_FILE)
	@echo "✅ Project structure created"