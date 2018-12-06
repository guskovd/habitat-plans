#!/usr/bin/env bash
# -*- coding: utf-8 -*-

set -e

export HAB_ORIGIN="guskovd"

if [[ "$(uname -s)" == "Linux" ]]; then # Linux setup
    echo "export GITHUB_TOKEN=$GITHUB_TOKEN" > habitat/tmp/env.sh
    cp -rf .hab $HOME/.hab
    curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash
    results=results
    last_build=results/last_build.env
else # Windows setup
    echo "\$env:GITHUB_TOKEN=\"$GITHUB_TOKEN\"" > habitat/tmp/env.ps1
    cp -rf .hab /c/hab
    choco install habitat
    results=habitat/${HAB_PKG}/results
    last_build=habitat/${HAB_PKG}/results/last_build.ps1
fi

hab studio build habitat/${HAB_PKG}

pkg_artifact=$(cat $last_build | grep pkg_artifact | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')
pkg_ident=$(cat $last_build | grep pkg_ident | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')
pkg_origin=$(cat $last_build | grep pkg_origin | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')
pkg_version=$(cat $last_build | grep pkg_version | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')
pkg_name=$(cat $last_build | grep pkg_name | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')

if [[ ! $(hab pkg search $pkg_origin/$pkg_name | grep $pkg_origin/$pkg_name/$pkg_version) ]]; then
    echo "Uploading artifact ..."
    hab pkg upload $results/$pkg_artifact
else
    echo "Package exist on hab depot. Skip"
fi
