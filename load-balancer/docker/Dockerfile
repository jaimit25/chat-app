FROM nginx:stable-alpine

# Copy custom NGINX config into container
COPY ../src/nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
