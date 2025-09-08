FROM kong/kong-gateway:3.4

USER root
RUN apt-get update && apt-get install -y curl && apt-get clean

COPY ../src/kong.yml /usr/local/kong/declarative/kong.yml

EXPOSE 8000 8443 8001 8444

CMD ["kong", "start", "--vv"]
