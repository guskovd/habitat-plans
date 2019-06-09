pkg_name=cni-plugins
pkg_origin=guskovd
pkg_version="0.6.0"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/containernetworking/plugins/releases/download/v${pkg_version}/cni-plugins-amd64-v${pkg_version}.tgz"
pkg_shasum="f04339a21b8edf76d415e7f17b620e63b8f37a76b2f706671587ab6464411f2d"

pkg_bin_dirs=(bin)

do_unpack() {
    mkdir -p "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
    tar -xvf ${HAB_CACHE_SRC_PATH}/cni-plugins-amd64-v0.6.0.tgz -C "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
}

do_build() {
    return 0
}

do_install() {
    cp -a . "${pkg_prefix}/bin"
}
