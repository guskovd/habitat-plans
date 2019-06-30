pkg_name=vagrant
pkg_origin=guskovd
pkg_version='2.2.4'
pkg_description="Build and distribute virtualized development environments"
pkg_maintainer='Danil Guskov'
pkg_license=('MIT')
pkg_upstream_url="https://vagrantup.com"
pkg_source=https://github.com/mitchellh/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=4f8ce6ede5d47a2be1ce46a29d22d41d1f4ba9d99fe9496b2424f98ae4dab2d6
pkg_bin_dirs=(exec)

pkg_deps=(
    core/ruby
    core/bundler
    core/coreutils
)

pkg_build_deps=(
    core/git
    core/make
    core/gcc
)

do_build() {
    local _bundler_dir
    _bundler_dir=$(pkg_path_for bundler)

    export GEM_HOME=${pkg_path}/vendor/bundle
    export GEM_PATH=${_bundler_dir}:${GEM_HOME}

    bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs exec
}

do_install () {
    cp -R . "$pkg_prefix/"
    fix_interpreter "$pkg_prefix/exec/*" core/ruby ruby
}
