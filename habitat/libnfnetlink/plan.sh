pkg_origin=guskovd
pkg_name=libnfnetlink
pkg_version=1.0.1
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_upstream_url="http://www.netfilter.org/projects/libnfnetlink/"
pkg_source="http://www.netfilter.org/projects/libnfnetlink/files/libnfnetlink-1.0.1.tar.bz2"
pkg_shasum=f270e19de9127642d2a11589ef2ec97ef90a649a74f56cf9a96306b04817b51a
pkg_build_deps=(
    core/gcc core/make core/m4
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
