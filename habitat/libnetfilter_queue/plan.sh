pkg_name=libnetfilter_queue
pkg_origin=guskovd
pkg_version="1.0.3"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://netfilter.org/projects/libnetfilter_queue/files/libnetfilter_queue-${pkg_version}.tar.bz2"
pkg_shasum="9859266b349d74c5b1fdd59177d3427b3724cd72a97c49cc2fffe3b55da8e774"

pkg_bin_dirs=(bin)

pkg_build_deps=(
    core/gcc
    core/make
    core/pkg-config
    guskovd/libnfnetlink
    guskovd/libmnl
)
