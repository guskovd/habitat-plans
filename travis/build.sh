#!/usr/bin/env sh
# -*- coding: utf-8 -*-

mkdir -p $HOME/.hab/cache/keys

export HAB_ORIGIN="guskovd"

openssl aes-256-cbc -K $encrypted_d9af3f5ac913_key -iv $encrypted_d9af3f5ac913_iv -in .hab.tar.enc -out .hab.tar -d
tar xvf .hab.tar

ls $HOME -lha

# cp .hab $HOME -rf

# choco install habitat
# hab studio build habitat/selenoid-bin
