#!/usr/bin/env sh
# -*- coding: utf-8 -*-

export HAB_ORIGIN="guskovd"

cp -rf .hab /c/hab

choco install habitat
hab studio build habitat/${HAB_PKG}

pkg_artifact=$(cat habitat/${HAB_PKG}/results/last_build* | grep pkg_artifact | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')
pkg_ident=$(cat habitat/${HAB_PKG}/results/last_build.* | grep pkg_ident | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')

hab pkg upload habitat/${HAB_PKG}/results/$pkg_artifact
