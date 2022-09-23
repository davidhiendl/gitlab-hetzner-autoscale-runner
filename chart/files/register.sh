#!/bin/bash

# gitlab-runner data directory
DATA_DIR="/etc/gitlab-runner"
CONFIG_FILE=${CONFIG_FILE:-$DATA_DIR/config.toml}
CONFIG_TEMPLATE_FILE=${CONFIG_TEMPLATE_FILE:-/gitlab-runner-config/config.template.toml}
# custom certificate authority path
CA_CERTIFICATES_PATH=${CA_CERTIFICATES_PATH:-$DATA_DIR/certs/ca.crt}
LOCAL_CA_PATH="/usr/local/share/ca-certificates/ca.crt"

update_ca() {
  echo "Updating CA certificates..."
  cp "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}"
  update-ca-certificates --fresh >/dev/null
}

if [ -f "${CA_CERTIFICATES_PATH}" ]; then
  # update the ca if the custom ca is different than the current
  cmp --silent "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}" || update_ca
fi

# check variables for runner registration
if [[ -z "$REGISTRATION_TOKEN" ]]; then
    echo "ERROR: missing env variable: REGISTRATION_TOKEN"
    exit 1
fi
if [[ -z "$CI_SERVER_URL" ]]; then
    echo "ERROR: missing env variable: CI_SERVER_URL"
    exit 1
fi

# register runner
gitlab-runner register \
    -n \
    --template-config=$CONFIG_TEMPLATE_FILE \
    --config=$CONFIG_FILE \
    --executor docker+machine \
    --locked \
    --docker-image=ruby:2.5
