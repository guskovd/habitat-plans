pkg_name=gsopcast
pkg_origin=guskovd
pkg_version='0.4.0'
pkg_description="The Streaming Direct Broadcast System based on P2P"
pkg_maintainer='Danil Guskov'
pkg_license=('custom')
pkg_upstream_url="http://www.sopcast.org"
pkg_source=https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/gsopcast/gsopcast-${pkg_version}.tar.bz2
pkg_shasum=be90eee9e31ce4232511bc6555c8dde75ed813efa97a483bb6fa5c20c3ebb155
pkg_bin_dirs=(bin)

pkg_build_deps=(
    core/make
    core/gcc
    core/gtk2
    core/pango
    core/glib
    core/pcre
    core/cairo
    core/pixman
    core/fontconfig
    core/freetype
    core/zlib
    core/libpng
    core/expat
    core/harfbuzz
    core/gdk-pixbuf
    core/atk
    core/alsa-lib
)

pkg_deps=(
    core/gtk2
    core/cairo
    core/pango
    core/atk
    core/gdk-pixbuf
    core/glib
    core/fontconfig
    core/freetype
    core/alsa-lib
    core/gcc-libs
    guskovd/sopcast
)

do_build() {
    pushd $HAB_CACHE_SRC_PATH/gsopcast-0.2.11/src
    attach
    make CFLAGS+=`pkg-config --cflags gtk+-2.0 --cflags alsa` LDFLAGS+="`pkg-config --libs gtk+-2.0` -lasound"
}

do_install () {
    pushd $HAB_CACHE_SRC_PATH/gsopcast-0.2.11/src
    install gsopcast $pkg_prefix/bin
}
