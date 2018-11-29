pkg_name=gitbook-cli
pkg_origin=guskovd
pkg_version="2.3.2"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/GitbookIO/gitbook-cli/archive/2.3.2.tar.gz"
pkg_shasum="693db6473c5ab9863161146733c7c374f8d053da908cddb6cc5528b4277d4197"

pkg_deps=(
    core/node
)

pkg_build_deps=(
    core/git
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
    npm config set progress false
    npm config set prefix "$pkg_prefix"
}

do_build() {
    npm install
    npm shrinkwrap
}

do_install() {
    cp -r ./* "${pkg_prefix}/"
    pushd ${pkg_prefix}/bin/
    ln -sf gitbook.js gitbook
    popd
}
