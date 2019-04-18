pkg_name=b2sum
pkg_origin=guskovd
pkg_version='2013-02-15'
pkg_description="Utility to calculate BLAKE2 checksums written in Go."
pkg_maintainer='Danil Guskov'
pkg_license=('LGPL-2.1')
pkg_upstream_url="https://bitbucket.org/dchest/b2sum"
pkg_source=https://bitbucket.org/dchest/b2sum/downloads/b2sum_linux_amd64.zip
pkg_shasum=89aa3626e394969b353b00a873ca4a78beabee7c2dea34b04fbad1da26b024a2
pkg_bin_dirs=(bin)

do_build() {
    return 0
}

do_install () {
    cp $HAB_CACHE_SRC_PATH/b2sum $pkg_prefix/bin/b2sum
    chmod '+x' $pkg_prefix/bin/b2sum
}
