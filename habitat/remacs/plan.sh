pkg_name=remacs
pkg_origin=guskovd
pkg_version="0207a05ce4aa8e1531a986dc1cd9dcd23181db40"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/Wilfred/remacs/archive/$pkg_version.tar.gz"
pkg_shasum="a01d60f1ea29de044cbe1c07234419681870f564b17fead68ba841be33068e07"
pkg_deps=(
    core/gtk
    core/gcc-libs
    core/ncurses
    core/zlib
    core/imagemagick
    core/pango
    core/glib
    core/pcre
    core/cairo
    core/pixman
    core/fontconfig
    core/freetype
    core/libpng
    core/expat
    core/harfbuzz
    core/gdk-pixbuf
    core/atk
    core/giflib
    core/libtiff
    core/libjpeg-turbo
    core/xlib
    core/libxcb
    core/libxau
    core/libxdmcp
    core/libxt
    core/libice
    core/libsm
    core/libxext
    core/libxrender
    core/libxmu
)
pkg_build_deps=(
    core/coreutils
    core/rust-nightly
    core/gcc
    core/make
    core/autoconf
    core/automake
    core/gzip
    core/texinfo
    core/glibc
    core/zlib
    core/gmp
    core/pkg-config
    core/xproto
    core/kbproto
    core/libpthread-stubs
    core/renderproto
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
    if [[ ! -r /bin/pwd ]]; then
	ln -sv "$(pkg_path_for coreutils)/bin/pwd" /bin/pwd
	_clean_pwd=true
    fi
}

do_clean() {
    # Prevent rm -rf "$CACHE_PATH"
    return 0
}

do_build() {
    ./autogen.sh
    ./configure --with-gnutls=no --with-xft --with-modules --with-x-toolkit=gtk3 --without-gconf --with-gsettings --without-makeinfo RUSTFLAGS="-g" --prefix="$pkg_prefix"
    make
}

do_install() {
    make install
}

do_end() {
    # Clean up the `pwd` link, if we set it up.
    if [[ -n "$_clean_pwd" ]]; then
	rm -fv /bin/pwd
    fi
}
