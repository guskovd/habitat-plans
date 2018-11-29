#!/usr/bin/env sh
# -*- coding: utf-8 -*-

mkdir -p $HOME/.hab/cache/keys

export HAB_ORIGIN="guskovd"

openssl aes-256-cbc -K $encrypted_d9af3f5ac913_key -iv $encrypted_d9af3f5ac913_iv -in .hab/cache/keys/guskovd-20170522132207.pub.enc -out $HOME/.hab/cache/keys/guskovd-20170522132207.pub -d
openssl aes-256-cbc -K $encrypted_d9af3f5ac913_key -iv $encrypted_d9af3f5ac913_iv -in .hab/cache/keys/guskovd-20170522132207.sig.key.enc -out $HOME/.hab/cache/keys/guskovd-20170522132207.sig.key -d

choco install habitat
hab studio build habitat/selenoid-bin
