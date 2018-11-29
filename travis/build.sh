#!/usr/bin/env sh
# -*- coding: utf-8 -*-

export HAB_ORIGIN="guskovd"

cp -rf .hab /c/hab

choco install habitat
hab studio build habitat/selenoid-bin

pkg_artifact=$(cat habitat/selenoid-bin/results/last_build.ps1 | grep pkg_artifact | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')
pkg_ident=$(cat habitat/selenoid-bin/results/last_build.ps1 | grep pkg_ident | awk -F '=' '{print $2}' | sed $'s/[\r:\"]//g')

hab pkg upload habitat/selenoid-bin/results/$pkg_artifact
