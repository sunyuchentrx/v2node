# v2node
A v2board backend base on moddified xray-core.
一个基于修改版xray内核的V2board节点服务端。

**注意： 本项目需要搭配[修改版V2board](https://github.com/wyx2685/v2board)**

## 软件安装

### 一键安装

```
wget -N https://raw.githubusercontent.com/sunyuchentrx/v2node/main/script/install.sh && bash install.sh
```

### Override installed binary

Binary path: `/usr/local/v2node/v2node`

``` bash
VERSION=v1.0.0-finalmaskfix1; ARCH=$(uname -m); case "$ARCH" in x86_64|amd64) ASSET=linux-64 ;; aarch64|arm64) ASSET=linux-arm64-v8a ;; *) echo "unsupported arch: $ARCH"; exit 1 ;; esac; TMP=$(mktemp -d); curl -L "https://github.com/sunyuchentrx/v2node/releases/download/${VERSION}/v2node-${ASSET}.zip" -o "$TMP/v2node.zip" && unzip -o "$TMP/v2node.zip" v2node -d "$TMP" && install -m 755 "$TMP/v2node" /usr/local/v2node/v2node.new && mv /usr/local/v2node/v2node.new /usr/local/v2node/v2node && systemctl restart v2node && rm -rf "$TMP"
```

## 构建
``` bash
GOEXPERIMENT=jsonv2 go build -v -o build_assets/v2node -trimpath -ldflags "-X 'github.com/wyx2685/v2node/cmd.version=$version' -s -w -buildid="
```

## Stars 增长记录

[![Stargazers over time](https://starchart.cc/sunyuchentrx/v2node.svg?variant=adaptive)](https://starchart.cc/sunyuchentrx/v2node)
