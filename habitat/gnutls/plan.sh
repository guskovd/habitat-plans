pkg_name=gnutls
pkg_origin=guskovd
pkg_version='3.6.8'
pkg_description="Gnu TLS"
pkg_maintainer='Danil Guskov'
pkg_license=('LGPL-2.1')
pkg_upstream_url="https://www.gnupg.org/ftp/gcrypt/gnutls"
pkg_source=https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.8.tar.xz
pkg_shasum=aa81944e5635de981171772857e72be231a7e0f559ae0292d2737de475383e83

pkg_build_deps=(
    core/gcc
    core/make
    core/nettle
    core/pkg-config
    core/gmp
    core/libtasn1
    core/libunistring
    core/p11-kit
)
