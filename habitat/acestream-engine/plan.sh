pkg_name=acestream-engine
pkg_origin=guskovd
pkg_version="3.1.16"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="http://dl.acestream.org/linux/acestream_${pkg_version}_ubuntu_16.04_x86_64.tar.gz"
pkg_shasum="452bccb8ae8b5ff4497bbb796081dcf3fec2b699ba9ce704107556a3d6ad2ad7"
pkg_dirname="acestream_${pkg_version}_ubuntu_16.04_x86_64"

pkg_deps=(
    core/net-tools
    core/openssl
    core/python2
    core/virtualenv
    core/zlib
)

pkg_build_deps=(
    core/gcc
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
    virtualenv "$pkg_prefix"
    source "$pkg_prefix/bin/activate"
}

do_install() {
    cp -rf $HAB_CACHE_SRC_PATH/$pkg_dirname/* $pkg_prefix/bin
    pip install m2crypto
    pip install xlib
    pip install apsw
    pip install lxml
    pip install typing
}

do_build() {
    return 0
}
