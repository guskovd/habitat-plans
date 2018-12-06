#!/usr/bin/env sh
# -*- coding: utf-8 -*-

. ../tmp/env.sh

get_latest_release() {
    uri="https://api.github.com/repos/$1/releases/latest?access_token=${GITHUB_TOKEN}"
    echo "web request uri: $uri"
    curl --silent $uri | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}
