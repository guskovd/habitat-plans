#!/usr/bin/env sh
# -*- coding: utf-8 -*-

export HAB_ORIGIN="guskovd"

cp -rf .hab /c 

choco install habitat
hab studio build habitat/selenoid-bin
