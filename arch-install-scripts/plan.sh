pkg_name=arch-install-scripts
pkg_origin=guskovd
pkg_version="19"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/falconindy/arch-install-scripts/archive/v${pkg_version}.tar.gz"
pkg_shasum="101f575bb1ae33083fba330fa3b869eddfc0d703203c7d55b8f0d436ee7c5578"

pkg_build_deps=(
    core/make
    core/m4
)

pkg_deps=(
    core/coreutils
    core/util-linux
    core/gawk
)

pkg_bin_dirs=(bin)

do_install() {
    echo hello
    make
}

do_build() {
    make install PREFIX="$pkg_prefix"
}
