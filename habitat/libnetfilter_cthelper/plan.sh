pkg_name=libnetfilter_cthelper
pkg_origin=guskovd
pkg_version="1.0.0"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://netfilter.org/projects/libnetfilter_cthelper/files/libnetfilter_cthelper-${pkg_version}.tar.bz2"
pkg_shasum="07618e71c4d9a6b6b3dc1986540486ee310a9838ba754926c7d14a17d8fccf3d"

pkg_bin_dirs=(bin)

pkg_build_deps=(
    core/gcc
    core/make
    core/pkg-config
    guskovd/libmnl
)
