FROM debian:bookworm-slim

COPY install.sh /app/install.sh
COPY entrypoint.sh /entrypoint.sh

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash git curl wget unzip tzdata openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /app/install.sh && /app/install.sh
COPY config.json /etc/config.json

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
