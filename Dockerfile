FROM alpine:latest

# Instalar dependências necessárias
RUN apk add --no-cache ca-certificates wget unzip

WORKDIR /app

# Baixar o PocketBase Linux direto do GitHub
# (troque a versão v0.22.3 pela que você quiser usar)
RUN wget -O pocketbase.zip \
  https://github.com/pocketbase/pocketbase/releases/download/v0.22.3/pocketbase_0.22.3_linux_amd64.zip \
  && unzip pocketbase.zip \
  && mv pocketbase_*/pocketbase /app/pocketbase \
  && chmod +x /app/pocketbase \
  && rm -rf pocketbase.zip pocketbase_*

# Pasta onde o PocketBase vai guardar os dados
RUN mkdir -p /app/data

EXPOSE 8090

CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir", "/app/data"]
