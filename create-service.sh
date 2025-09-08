#!/bin/bash

# Script to scaffold a basic .NET Core microservice structure

read -p "Enter the service name: " SERVICE_NAME

if [ -z "$SERVICE_NAME" ]; then
    echo "Service name cannot be empty!"
    exit 1
fi

# Create root folder
mkdir -p "$SERVICE_NAME"

# Create docker folder and Dockerfile
mkdir -p "$SERVICE_NAME/docker"
cat > "$SERVICE_NAME/docker/Dockerfile" <<EOF
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY ../src/*.csproj ./
RUN dotnet restore
COPY ../src/. ./
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
ENTRYPOINT ["dotnet", "${SERVICE_NAME}.dll"]
EOF

# Create k8s folder and deployment/service YAMLs
mkdir -p "$SERVICE_NAME/k8s"

cat > "$SERVICE_NAME/k8s/${SERVICE_NAME}-deployment.yaml" <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${SERVICE_NAME}
  namespace: chat-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${SERVICE_NAME}
  template:
    metadata:
      labels:
        app: ${SERVICE_NAME}
    spec:
      containers:
        - name: ${SERVICE_NAME}
          image: ${SERVICE_NAME}:v1
          ports:
            - containerPort: 8080
EOF

cat > "$SERVICE_NAME/k8s/${SERVICE_NAME}-service.yaml" <<EOF
apiVersion: v1
kind: Service
metadata:
  name: ${SERVICE_NAME}
  namespace: chat-app
spec:
  type: ClusterIP
  selector:
    app: ${SERVICE_NAME}
  ports:
    - port: 8080
      targetPort: 8080
EOF

# Create empty src folder
mkdir -p "$SERVICE_NAME/src"

echo "Service structure created for '$SERVICE_NAME':"
tree "$SERVICE_NAME"
