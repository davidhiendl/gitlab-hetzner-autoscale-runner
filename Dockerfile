FROM ubuntu as builder

WORKDIR /build

RUN apt-get update \
&&  apt-get install -y \
    curl \
    tar \
    jq \
&&  curl -sLo hetzner.tar.gz $(curl --silent https://api.github.com/repos/JonasProgrammer/docker-machine-driver-hetzner/releases \
    | jq -r '. | first | .assets[] | select(.name|contains("linux_amd64")).browser_download_url') \
&&  tar xf hetzner.tar.gz \
&&  chmod +x docker-machine-driver-hetzner

FROM gitlab/gitlab-runner:v15.4.0
COPY --from=builder /build/docker-machine-driver-hetzner /usr/bin
