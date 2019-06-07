pkg_name=libnetfilter_conntrack
pkg_origin=guskovd
pkg_version="1.0.7"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://www.netfilter.org/projects/libnetfilter_conntrack/files/libnetfilter_conntrack-${pkg_version}.tar.bz2"
pkg_shasum="33685351e29dff93cc21f5344b6e628e41e32b9f9e567f4bec0478eb41f989b6"

pkg_bin_dirs=(bin)

pkg_build_deps=(
    core/gcc
    core/make
    core/pkg-config
    guskovd/libnfnetlink
    guskovd/libmnl
)

