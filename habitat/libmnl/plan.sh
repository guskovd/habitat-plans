pkg_origin=guskovd
pkg_name=libmnl
pkg_version=1.0.4
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_upstream_url="http://www.netfilter.org/projects/libmnl/"
pkg_source="https://www.netfilter.org/projects/libmnl/files/libmnl-1.0.4.tar.bz2"
pkg_shasum=171f89699f286a5854b72b91d06e8f8e3683064c5901fb09d954a9ab6f551f81
pkg_build_deps=(
    core/gcc
    core/make
    core/m4
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
    ./configure --prefix="${pkg_prefix}"
    make PREFIX="$pkg_prefix"
}

do_install() {
    make install PREFIX="$pkg_prefix"
}

do_check() {
    make test
}
