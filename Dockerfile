# STAGE 1: Builder
# Downloads and extracts the AdGuardHome binary for ARMv5
FROM arm32v5/debian:bookworm-slim AS builder

ARG DEBIAN_FRONTEND=noninteractive
ARG AGH_VERSION=""

WORKDIR /tmp/build

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        tar && \
    rm -rf /var/lib/apt/lists/*

# Download and extract AdGuardHome release
# If AGH_VERSION is passed, use it; otherwise fetch latest
RUN set -eux; \
    if [ -z "$AGH_VERSION" ]; then \
      AGH_VERSION=$(curl -sL https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest | jq -r .tag_name); \
    fi; \
    echo "Downloading AdGuardHome ${AGH_VERSION}..."; \
    curl -fSL "https://github.com/AdguardTeam/AdGuardHome/releases/download/${AGH_VERSION}/AdGuardHome_linux_armv5.tar.gz" -o agh.tar.gz; \
    tar -xzf agh.tar.gz

# STAGE 2: Final Runtime
FROM arm32v5/debian:bookworm-slim

LABEL maintainer="RAW-Network" \
      description="AdGuardHome Docker image optimized for ARMv5 (legacy devices)"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    LANG=en_US.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        tzdata && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/adguardhome

COPY --from=builder /tmp/build/AdGuardHome/AdGuardHome .

RUN mkdir -p work conf && \
    chmod +x ./AdGuardHome

EXPOSE 53/tcp 53/udp 67/udp 68/udp 80/tcp 443/tcp 853/tcp 853/udp 784/udp 8853/udp 5443/tcp 5443/udp 3000/tcp

CMD ["./AdGuardHome", \
     "--work-dir", "/opt/adguardhome/work", \
     "--config", "/opt/adguardhome/conf/AdGuardHome.yaml"]
