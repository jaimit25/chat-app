# user-service.mk

.PHONY: build docker deploy all

user-service-build:
	dotnet build user-service/src/UserService/UserService.csproj -c Release
	docker build -t user-service/user-service:v1 -f user-service/docker/Dockerfile user-service

user-service-deploy:
	kubectl apply -f user-service/k8s/user-service-deployment.yaml -n chat-app
	kubectl apply -f user-service/k8s/user-service-service.yaml -n chat-app

user-service-delete:
	kubectl delete deployment user-service -n chat-app --ignore-not-found=true
	kubectl delete service user-service -n chat-app --ignore-not-found=true



