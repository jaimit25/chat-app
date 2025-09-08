# =====================
# Stage 1: Build
# =====================
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY src/UserService/UserService.csproj ./
RUN dotnet restore UserService.csproj

# Copy the rest of the source code
COPY src/UserService/. ./

# Publish the project to /app/publish
RUN dotnet publish UserService.csproj -c Release -o /app/publish

# =====================
# Stage 2: Runtime
# =====================
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy published files from build stage
COPY --from=build /app/publish ./

# Expose port 80 for the service
EXPOSE 80

# Start the service
ENTRYPOINT ["dotnet", "UserService.dll"]