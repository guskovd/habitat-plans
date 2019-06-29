pkg_name=firefox
pkg_origin=guskovd
pkg_version='67.0.4'
pkg_description="Firefox Binary"
pkg_maintainer='Danil Guskov'
pkg_license=('LGPL-2.1')
pkg_upstream_url="https://www.mozilla.org/en-US/firefox/"
pkg_source=https://ftp.mozilla.org/pub/firefox/releases/${pkg_version}/linux-x86_64/en-US/firefox-${pkg_version}.tar.bz2
pkg_shasum=3bde74d9d958552081fad3b9c34db636abecedd48d947910d5f74e367af523b7
pkg_bin_dirs=(bin)

pkg_deps=(
    core/gcc-libs
    core/gtk
)

do_build() {
    return 0
}

do_install () {
    cp -rf $HAB_CACHE_SRC_PATH/firefox/* $pkg_prefix/bin
}
