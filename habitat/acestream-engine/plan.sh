pkg_name=acestream-engine
pkg_origin=guskovd
pkg_version="1.0.1"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")

pkg_svc_user="root"

pkg_deps=(
    core/sudo
    core/hab
    guskovd/acestream-engine-bin
)

do_download () {
    return 0
}

do_unpack () {
    return 0
}

do_install() {
    return 0
}

do_build() {
    return 0
}
