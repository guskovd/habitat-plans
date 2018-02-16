pkg_name=remacs
pkg_origin=guskovd
pkg_version="26.0.50"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/Wilfred/remacs"
pkg_deps=(
    core/gtk2
    core/ncurses
    core/rust
    lilian/gcc
    lilian/gcc-libs
    core/cargo-nightly
    core/zlib
    core/coreutils
    core/imagemagick
    core/glibc
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
    xorg/xlib/1.6.5/20170607234030
    xorg/libxcb/1.12/20170607233918
    xorg/libXau/1.0.8/20170607233814
    xorg/libXdmcp/1.1.2/20170607233905
    xorg/libXt/1.1.5/20170607234359
    xorg/libice/1.0.9/20170607233827
    xorg/libsm/1.2.2/20170607233852
    xorg/libxext/1.3.3/20170607234437
    xorg/libxrender/0.9.10/20170607234342
    xorg/libxmu/1.1.2/20170607234455
)
pkg_build_deps=(
    core/git core/make
    core/autoconf
    core/automake
    core/gzip
    core/texinfo
    core/glibc
    core/zlib
    core/gmp
    core/pkg-config
    xorg/xproto/7.0.31/20170607233653
    xorg/kbproto/1.0.7/20170607233756
    xorg/libpthread-stubs/0.4/20170607233627
    xorg/renderproto/0.11.1/20170607233728
    xorg/renderproto/0.11.1/20170607233728
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
    ./configure --with-x-toolkit=gtk2 --with-gnutls=no --with-gconf --without-gsettings --prefix="$pkg_prefix" --with-xpm=no
    make
}

do_install() {
    mkdir -p "$pkg_prefix"
    cd $HAB_CACHE_SRC_PATH/remacs
    make install
}

do_end() {
  # Clean up the `pwd` link, if we set it up.
  if [[ -n "$_clean_pwd" ]]; then
    rm -fv /bin/pwd
  fi
}
