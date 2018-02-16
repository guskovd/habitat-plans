pkg_name=remacs
pkg_origin=guskovd
pkg_version="0b3e23cb90d7039e370423ac620300fc19294884"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/Wilfred/remacs"
pkg_deps=(core/gtk2 core/ncurses core/rust lilian/gcc lilian/gcc-libs core/cargo-nightly core/zlib)
pkg_build_deps=(core/git core/make core/autoconf core/automake core/gzip core/texinfo core/glibc core/zlib core/gmp core/coreutils core/pkg-config)
pkg_bin_dirs=(bin)

do_download() {
    mkdir -p $HAB_CACHE_SRC_PATH/remacs
    pushd $HAB_CACHE_SRC_PATH/remacs
    git init
    git remote add origin $pkg_source || echo "already exist"
    git fetch --depth 1 origin
    git checkout FETCH_HEAD
    popd
}

do_unpack() {
    return 0
}

do_build() {
    cd $HAB_CACHE_SRC_PATH/remacs
    ./autogen.sh 
    ./configure --with-x-toolkit=gtk2 --with-gnutls=no --with-gconf --without-gsettings
    make
}

do_install() {
    mkdir -p "$pkg_prefix"/bin
    cp $HAB_CACHE_SRC_PATH/remacs/src/remacs "$pkg_prefix"/bin
    cp $HAB_CACHE_SRC_PATH/remacs/lib-src/remacsclient "$pkg_prefix"/bin
}
