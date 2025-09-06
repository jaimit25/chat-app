# make-scripts/namespace.mk



.PHONY: namespace-create
namespace-create:
	@kubectl apply -f infra/k8s/namespace.yaml
	