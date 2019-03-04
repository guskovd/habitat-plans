pkg_name=remacs
pkg_origin=guskovd
pkg_version="950f488504cbf33977e5a3c7bd2852f6177f7bc8"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/Wilfred/remacs/archive/$pkg_version.tar.gz"
pkg_shasum="62addb3535204f01129d3c976e112eb2b0f0d6173e7762b8e3ce55fe26e531b0"
pkg_deps=(
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
)
pkg_build_deps=(
    core/openssl
    core/coreutils
    guskovd/rustup
    # core/rust-nightly
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
    rustup-init -y
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

# _install_dependency() {
#     local dep="${1}"
#     if [[ -z "${NO_INSTALL_DEPS:-}" ]]; then
# 	$HAB_BIN pkg path "$dep" || $HAB_BIN install -u $HAB_BLDR_URL --channel $HAB_BLDR_CHANNEL "$dep" || {
# 		if [[ "$HAB_BLDR_CHANNEL" != "$FALLBACK_CHANNEL" ]]; then
# 		    build_line "Trying to install '$dep' from '$FALLBACK_CHANNEL'"
# 		    $HAB_BIN install -u $HAB_BLDR_URL --channel "$FALLBACK_CHANNEL" "$dep" || true
# 		fi
# 	    }
#     fi
#     return 0
# }
