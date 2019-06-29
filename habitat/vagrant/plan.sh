pkg_name=vagrant
pkg_origin=guskovd
pkg_version='2.2.4'
pkg_description="Build and distribute virtualized development environments"
pkg_maintainer='Danil Guskov'
pkg_license=('MIT')
pkg_upstream_url="https://vagrantup.com"
pkg_source=https://github.com/mitchellh/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=4f8ce6ede5d47a2be1ce46a29d22d41d1f4ba9d99fe9496b2424f98ae4dab2d6
pkg_bin_dirs=(bin)

pkg_deps=(
    core/ruby
)

pkg_build_deps=(
    core/git
    core/make
    core/gcc
)

do_build() {
    gem build ${pkg_name}.gemspec
    bundle
}

do_install () {
    bundle --binstubs bin
    attach
}
