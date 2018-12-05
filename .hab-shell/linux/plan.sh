pkg_name=guskovd-plans
pkg_origin=guskovd
pkg_version='1.20'
pkg_description="guskovd habitat plans"
pkg_maintainer='guskovd'
pkg_upstream_url="https://github.com/guskovd/habitat-plans"

pkg_hab_shell_interpreter="bash"

RUBY_VERSION=2.5.1

pkg_deps=(
    core/bash
    core/coreutils
    core/gawk
    core/which
    core/hab
    core/grep
    core/sed
    core/sudo
    core/make
    core/git
    core/ruby/$RUBY_VERSION
    core/tar
    core/docker
    core/sshpass
    core/rsync
    guskovd/python-openstackclient
)

do_shell() {
    . ~/.bashrc
    unset HAB_CACHE_KEY_PATH
    export HAB_ORIGIN="guskovd"
    ruby_bundle_path=$HOME/.hab-shell/ruby/bundle/$RUBY_VERSION

    mkdir -p $ruby_bundle_path
    export BUNDLE_PATH=$ruby_bundle_path

    pushd "$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" > /dev/null
    bundle install --binstubs > /dev/null
    popd > /dev/null

    export PATH="$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/bin:$PATH"
}

do_build() {
    return 0
}

do_install() {
    return 0
}

