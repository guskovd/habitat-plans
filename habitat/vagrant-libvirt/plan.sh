pkg_name=vagrant-libvirt
pkg_origin=guskovd
pkg_version='0.0.45'
pkg_description="libvirt provider plugin for Vagrant"
pkg_maintainer='Danil Guskov'
pkg_license=('MIT')
pkg_upstream_url="https://github.com/vagrant-libvirt/vagrant-libvirt"
pkg_source=https://github.com/vagrant-libvirt/vagrant-libvirt/archive/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=c504a081603be24550cc07671e384f1b7ba3b5507286ce5379458120652b3b01

pkg_deps=(
    core/ruby
    core/bundler
    core/coreutils
    core/openssl
)

pkg_build_deps=(
    core/git
    core/make
    core/gcc
)

do_setup_environment() {
    push_runtime_env GEM_PATH "${pkg_prefix}/vendor/bundle"
}

do_build() {
    local _bundler_dir
    _bundler_dir=$(pkg_path_for bundler)

    export GEM_HOME=${pkg_path}/vendor/bundle
    export GEM_PATH=${_bundler_dir}:${GEM_HOME}

    bundle install --jobs 2 --retry 5 --path ./vendor/bundle

    attach
}

do_install () {
    cp -R . "$pkg_prefix/"
    fix_interpreter "$pkg_prefix/exec/*" core/ruby ruby
}
