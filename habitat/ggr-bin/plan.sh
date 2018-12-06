pkg_name=ggr-bin
pkg_origin=guskovd
pkg_version='1.3.1'
pkg_description="Selenoid grid router binary"
pkg_maintainer='Danil Guskov'
pkg_license=('LGPL-2.1')
pkg_upstream_url="https://github.com/aerokube/ggr"
pkg_source=https://github.com/aerokube/ggr/releases/download/${pkg_version}/ggr_linux_amd64
pkg_shasum=c023695516709b654d6c08ffa4e74cd7b3001a3eaa8c0fd89f15acb9fbbf40ba
pkg_bin_dirs=(bin)

do_unpack () {
    return 0;
}

do_build() {
    return 0
}

do_install () {
    cp $HAB_CACHE_SRC_PATH/ggr_linux_amd64 $pkg_prefix/bin/ggr
    chmod '+x' $pkg_prefix/bin/ggr
}
