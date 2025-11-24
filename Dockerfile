FROM alpine:latest

# dependências
RUN apk add --no-cache ca-certificates wget unzip

WORKDIR /app

# baixar e extrair o pocketbase
RUN wget -O pocketbase.zip \
  https://github.com/pocketbase/pocketbase/releases/download/v0.22.3/pocketbase_0.22.3_linux_amd64.zip \
  && unzip pocketbase.zip \
  && mv pocketbase /app/pocketbase \
  && chmod +x /app/pocketbase \
  && rm -f pocketbase.zip CHANGELOG.md LICENSE.md

# pasta de dados
RUN mkdir -p /app/data

EXPOSE 8090

# usa a porta do Render se existir, senão 8090 (para rodar local)
CMD /app/pocketbase serve --http=0.0.0.0:${PORT:-8090} --dir /app/data
