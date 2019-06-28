pkg_name=sopcast
pkg_origin=guskovd
pkg_version='3.2.6'
pkg_description="The Streaming Direct Broadcast System based on P2P"
pkg_maintainer='Danil Guskov'
pkg_license=('custom')
pkg_upstream_url="http://www.sopcast.org"
pkg_source=http://download.easetuner.com/download/sp-auth.tgz
pkg_shasum=5ca407429dd54b0c195e05f06b33f79730a5dfdb8e7b14bf96b384f9ae8391d9
pkg_bin_dirs=(bin)

do_build() {
    return 0
}

do_install () {
    cp $HAB_CACHE_SRC_PATH/sp-auth/sp-sc-auth $pkg_prefix/bin/
    ln -sf $pkg_prefix/bin/sp-sc-auth $pkg_prefix/bin/sp-sc
    ln -sf $pkg_prefix/bin/sp-sc-auth $pkg_prefix/bin/sopcast
}
