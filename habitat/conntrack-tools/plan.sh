pkg_name=conntrack-tools
pkg_origin=guskovd
pkg_version="1.4.5"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://netfilter.org/projects/conntrack-tools/files/conntrack-tools-${pkg_version}.tar.bz2"
pkg_shasum="36c6d99c7684851d4d72e75bd07ff3f0ff1baaf4b6f069eb7244990cd1a9a462"

pkg_bin_dirs=(sbin)

pkg_deps=(
    guskovd/libnfnetlink
)

pkg_build_deps=(
    core/gcc
    core/bison
    core/flex
    core/pkg-config
    core/make
    guskovd/libnfnetlink
    guskovd/libmnl
    guskovd/libnetfilter_conntrack
    guskovd/libnetfilter_cttimeout
    guskovd/libnetfilter_cthelper
    guskovd/libnetfilter_queue
)

