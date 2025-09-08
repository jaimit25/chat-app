# Chat App

### Required Tools
- docker
- kubernetes client


Client → NGINX LB (port 80) → kong-proxy Service (port 8000) → API Gateway Pod (container 8080) → microservices

### port forward and access api-gateway kong
-  kubectl port-forward -n chat-app $(kubectl get pod -n chat-app -l app=kong -o name) 8001:8001

### load image in minikube 
- minikube image load load-balancer/lb-nginx:v1
- minikube image load api-gateway/kong:v1

### shift docker - minikube env point 
-  eval $(minikube -p minikube docker-env)

### corrective commands:
#### ErrImagePull error's | Image build Error
- minikube start --driver=docker --docker-opt="network=host" (allowing minikube to use same network)
- eval $(minikube docker-env) (minikube not able to find image) [shift to minikube docker env]
- eval $(minikube docker-env -u) [shift to local docker env]

### check images in minikube cluster  and remove
- minikube ssh -- docker images
- minikube ssh -- docker rmi -f $(minikube ssh -- docker images -q)

### ACCESS THE URL USING while using minikube
- kubectl expose deployment kong-gateway --type=NodePort --name=kong-proxy-nodeport -n chat-app
- kubectl expose deployment kong-gateway --type=NodePort --name=kong-proxy-nodeport -n chat-app
- minikube service lb-nginx-service -n chat-app
