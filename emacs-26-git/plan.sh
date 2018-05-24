pkg_name=emacs
pkg_origin=guskovd
pkg_version="4bb2741b7e28c0899af272f85a17e4f4399646de"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/emacs-mirror/emacs/archive/$pkg_version.tar.gz"
pkg_shasum="71ef235c5b1b7773e47ca436dfb7472536007716020ebc3830e0ff88adab8a20"
pkg_deps=(
    core/gtk2
    core/gcc-libs
    core/ncurses
    core/zlib
    core/coreutils
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

_install_dependency() {
    local dep="${1}"
    if [[ -z "${NO_INSTALL_DEPS:-}" ]]; then
	$HAB_BIN pkg path "$dep" || $HAB_BIN install -u $HAB_BLDR_URL --channel $HAB_BLDR_CHANNEL "$dep" || {
		if [[ "$HAB_BLDR_CHANNEL" != "$FALLBACK_CHANNEL" ]]; then
		    build_line "Trying to install '$dep' from '$FALLBACK_CHANNEL'"
		    $HAB_BIN install -u $HAB_BLDR_URL --channel "$FALLBACK_CHANNEL" "$dep" || true
		fi
	    }
    fi
    return 0
}

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
    cd $HAB_CACHE_SRC_PATH/
    cd emacs-$pkg_version
    ./autogen.sh
    ./configure --with-gnutls=no --with-xft --with-modules --with-x-toolkit=gtk2 --with-gconf --without-gsettings --without-makeinfo --prefix="$pkg_prefix" --with-xpm=no
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
