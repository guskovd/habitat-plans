pkg_name=libnetfilter_cttimeout
pkg_origin=guskovd
pkg_version="1.0.0"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://www.netfilter.org/projects/libnetfilter_cttimeout/files/libnetfilter_cttimeout-${pkg_version}.tar.bz2"
pkg_shasum="aeab12754f557cba3ce2950a2029963d817490df7edb49880008b34d7ff8feba"

pkg_bin_dirs=(bin)

pkg_build_deps=(
    core/gcc
    core/make
    core/pkg-config
    guskovd/libmnl
)

