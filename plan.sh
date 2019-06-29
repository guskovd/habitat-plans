pkg_name=guskovd-plans
pkg_origin=guskovd
pkg_version='1.20'
pkg_description="guskovd habitat plans"
pkg_maintainer='guskovd'
pkg_upstream_url="https://github.com/guskovd/habitat-plans"

pkg_hab_shell_interpreter="bash"

RUBY_VERSION=2.5.1

pkg_deps=(
    core/bash/4.4.19/20180608092913
    core/coreutils/8.29/20180608092141
    core/docker/18.03.0/20180608150948
    core/gawk/4.2.0/20180608093856
    core/git/2.18.0/20181218161804
    core/grep/3.1/20180608092809
    core/hab/0.79.0/20190409150529
    core/make/4.2.1/20180608100733
    core/rsync/3.1.2/20180608145950
    core/ruby/2.5.1/20181212185250
    core/sed/4.4/20180608091938
    core/sshpass/1.06/20180608151129
    core/sudo/1.8.18p1/20181219210923
    core/tar/1.30/20180608093304
    core/which/2.21/20180608164236
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

