pkg_name=git-lfs-bin
pkg_origin=guskovd
pkg_version='2.6.1'
pkg_description="Git extension for versioning large files"
pkg_maintainer='Danil Guskov'
pkg_license=('LGPL-2.1')
pkg_upstream_url="https://git-lfs.github.com"
pkg_source=https://github.com/git-lfs/git-lfs/releases/download/v${pkg_version}/git-lfs-linux-amd64-v${pkg_version}.tar.gz
pkg_shasum=c098092be413915793214a570cd51ef46089b6f6616b2f78e35ba374de613b5b
pkg_bin_dirs=(bin)

do_build() {
    return 0
}

do_install () {
    cp $HAB_CACHE_SRC_PATH/git-lfs $pkg_prefix/bin/git-lfs
}
