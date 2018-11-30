#!/usr/bin/env bash
# -*- coding: utf-8 -*-

export HAB_ORIGIN="guskovd"

if [[ "$(uname -s)" == "Linux" ]]; then # Linux setup
    cp -rf .hab $HOME/.hab
    curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash
    results=results
    last_build=results/last_build.env
else # Windows setup
    cp -rf .hab /c/hab
    choco install habitat
    results=habitat/${HAB_PKG}/results
    last_build=habitat/${HAB_PKG}/results/last_build.ps1
fi

hab studio build habitat/${HAB_PKG}

pkg_artifact=$(cat $last_build | grep pkg_artifact | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')
pkg_ident=$(cat $last_build | grep pkg_ident | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')

hab pkg upload $results/$pkg_artifact
