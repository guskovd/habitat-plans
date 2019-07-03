pkg_name=remacs
pkg_origin=guskovd
pkg_version="fb2e5d73bbd221568e9fbeaa2e6d169a422455de"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/Wilfred/remacs/archive/$pkg_version.tar.gz"
pkg_shasum="f9af7103de6212f7bf9878a9fcdb3aeb3d6935a5968495c85482623c0b3a67ba"
pkg_deps=(
    core/grep
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
    core/gtk
    core/openssl
    core/cacerts
    core/busybox-static
    core/coreutils
    core/diffutils
    guskovd/rustup/1.18.3
    guskovd/rust-nightly/1.35.0-2019-05-01
    core/gcc
    core/make
    core/autoconf
    core/automake
    core/gzip
    core/texinfo
    core/glibc
    core/gmp
    core/pkg-config
    core/xproto
    core/kbproto
    core/libpthread-stubs
    core/renderproto
    core/xextproto
    core/libxi
    core/inputproto
    core/libxfixes
    core/fixesproto
    core/libepoxy
    core/at-spi2-atk
    core/at-spi2-core
    core/dbus
    core/alsa-lib
    core/gnutls
    core/nettle
    core/libtasn1
    core/p11-kit
    core/clang
    core/clang-tools-extra
    core/file/5.34/20190115003731
    guskovd/libxpm/3.5.12
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
    if [[ ! -r /bin/pwd ]]; then
	ln -sv "$(pkg_path_for coreutils)/bin/pwd" /bin/pwd
	_clean_pwd=true
    fi
    # rustup-init -y
    # source $HOME/.cargo/env
}

do_clean() {
    # Prevent rm -rf "$CACHE_PATH"
    return 0
}

do_build() {
    # ./autogen.sh
    attach
    ./configure --with-gameuser=:games --with-sound=alsa --with-xft --with-modules --with-x-toolkit=gtk3 --without-gconf --with-gsettings --without-makeinfo --prefix="$pkg_prefix" --enable-rust-debug
    attach
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

