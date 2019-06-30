pkg_name=guskovd-plans
pkg_origin=guskovd
pkg_version='1.20'
pkg_description="guskovd habitat plans"
pkg_maintainer='guskovd'
pkg_upstream_url="https://github.com/guskovd/habitat-plans"

pkg_hab_shell_interpreter="bash"

RUBY_VERSION=2.5.5

pkg_deps=(
    core/bash/4.4.19/20190115012619
    core/coreutils/8.30/20190115012313
    core/docker/18.03.0/20190117151003
    core/gawk/4.2.1/20190115012752
    core/git/2.20.1/20190305233956
    core/grep/3.1/20190115012541
    core/hab/0.79.0/20190409150529
    core/make/4.2.1/20190115013626
    core/rsync/3.1.2/20190115215406
    core/ruby/2.5.5/20190416223112
    core/sed/4.5/20190115012152
    core/sshpass/1.06/20190115233635
    core/sudo/1.8.18p1/20190117185055
    core/tar/1.30/20190115012709
    core/which/2.21/20190430084037
    guskovd/vagrant/2.2.4/20190630061004
)

do_shell() {
    . ~/.bashrc
    unset HAB_CACHE_KEY_PATH

    export HAB_AUTH_TOKEN=_Qk9YLTEKYmxkci0yMDE3MDkyNzAyMzcxNApibGRyLTIwMTcwOTI3MDIzNzE0CkQ3RytwTURLWmZtZnBXKzAwZVlYbndSRnpETWoxRGdaCnBySk5iak9iU2E1dENDM0dTSnh2MDNUb3dSeGVSRFFDYWtlbXduSDRiLzQzOUNKcw
    export HAB_BLDR_URL=https://bldr.habitat.sh 
    export HAB_ORIGIN="guskovd"
    
    ruby_bundle_path=$HOME/.hab-shell/ruby/bundle/$RUBY_VERSION

    echo "export GITHUB_TOKEN=$GITHUB_TOKEN" > "$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/habitat/tmp/env.sh"
    echo "\$env:GITHUB_TOKEN=\"$GITHUB_TOKEN\"" > "$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/habitat/tmp/env.ps1"

    mkdir -p $ruby_bundle_path
    export BUNDLE_PATH=$ruby_bundle_path

    pushd "$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" > /dev/null
    bundle install --binstubs > /dev/null
    popd > /dev/null

    export PATH="$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.hab-shell/bin:$PATH"
    export PATH="$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/bin:$PATH"
}

do_build() {
    return 0
}

do_install() {
    return 0
}

