#!/usr/bin/env sh
# -*- coding: utf-8 -*-

get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest?access_token=${GITHUB_TOKEN}" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}
