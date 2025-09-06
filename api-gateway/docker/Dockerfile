FROM kong/kong-gateway:3.4

COPY ../src/kong.yml /usr/local/kong/declarative/kong.yml

EXPOSE 8000 8443 8001 8444

CMD ["kong", "start", "-c", "/usr/local/kong/declarative/kong.yml"]
