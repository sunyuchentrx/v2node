#!/bin/bash

set -e

REPO="sunyuchentrx/v2node"
VERSION="${1:-v1.0.0-finalmaskfix2}"
INSTALL_PATH="/usr/local/v2node/v2node"

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root."
    exit 1
fi

case "$(uname -m)" in
    x86_64|amd64)
        ASSET="linux-64"
        ;;
    aarch64|arm64)
        ASSET="linux-arm64-v8a"
        ;;
    *)
        echo "Unsupported arch: $(uname -m)"
        exit 1
        ;;
esac

if [[ ! -f "$INSTALL_PATH" ]]; then
    echo "v2node binary not found at $INSTALL_PATH"
    echo "Please install v2node first."
    exit 1
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

URL="https://github.com/${REPO}/releases/download/${VERSION}/v2node-${ASSET}.zip"

echo "Downloading ${URL}"
curl -fL "$URL" -o "$TMP_DIR/v2node.zip"

unzip -o "$TMP_DIR/v2node.zip" v2node -d "$TMP_DIR" >/dev/null
install -m 755 "$TMP_DIR/v2node" "${INSTALL_PATH}.new"
mv "${INSTALL_PATH}.new" "$INSTALL_PATH"

if command -v systemctl >/dev/null 2>&1; then
    systemctl restart v2node
else
    service v2node restart
fi

echo "v2node updated to ${VERSION}"
