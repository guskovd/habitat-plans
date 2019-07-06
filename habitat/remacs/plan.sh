pkg_name=remacs
pkg_origin=guskovd
pkg_version="fb2e5d73bbd221568e9fbeaa2e6d169a422455de"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/Wilfred/remacs/archive/$pkg_version.tar.gz"
pkg_shasum="f9af7103de6212f7bf9878a9fcdb3aeb3d6935a5968495c85482623c0b3a67ba"

# pkg_build_deps=(
#     core/grep
#     core/gcc
#     core/make
#     core/busybox-static
#     core/coreutils
#     core/diffutils
#     core/clang
#     core/clang-tools-extra
#     core/file/5.34/20190115003731
#     core/gawk
#     core/git
#     guskovd/rust-nightly/1.35.0-2019-05-01
# )

pkg_deps=(
    core/acl/2.2.53/20190115012136
    core/alsa-lib/1.1.9/20190611003813
    core/at-spi2-atk/2.26.1/20190306003033
    core/at-spi2-core/2.26.2/20190305235756
    core/atk/2.27.1/20190305235659
    core/autoconf/2.69/20190115013251
    core/automake/1.16/20190115013257
    core/cacerts/2018.12.05/20190115014206
    core/cairo/1.16.0/20190617095851
    core/clang-tools-extra/7.0.0/20190115175546
    core/clang/7.0.1/20190305224447
    core/coreutils/8.30/20190115012313
    core/dbus/1.13.8/20190201184338
    core/diffutils/3.6/20190115013221
    core/expat/2.2.5/20190115012836
    core/file/5.34/20190115003731
    core/fixesproto/5.0/20190115162717
    core/fontconfig/2.11.95/20190617095421
    core/freetype/2.9.1/20190502094019
    core/gawk/4.2.1/20190115012752
    core/gcc-libs/8.2.0/20190115011926
    core/gcc/8.2.0/20190115004042
    core/gdk-pixbuf/2.36.11/20190416163650
    core/giflib/5.1.4/20190117152214
    core/git/2.20.1/20190305233956
    core/glib/2.50.3/20190305224252
    core/glibc/2.27/20190115002733
    core/gmp/6.1.2/20190115003943
    core/gnutls/3.6.5/20190306203832
    core/grep/3.1/20190115012541
    core/gtk/3.22.22/20190617100752
    core/gzip/1.9/20190115013612
    core/hab/0.79.0/20190409150529
    core/harfbuzz/1.3.4/20190617100352
    core/imagemagick/6.9.2-10/20190416163557
    core/inputproto/2.3.2/20190115155741
    core/kbproto/1.0.7/20190115155737
    core/lcms2/2.8/20190117172258
    core/libepoxy/1.4.3/20190302021519
    core/libice/1.0.9/20190115155323
    core/libjpeg-turbo/1.5.0/20190115161838
    core/libpng/1.6.37/20190416161431
    core/libpthread-stubs/0.4/20190115155413
    core/libsm/1.2.2/20190115155338
    core/libtasn1/4.13/20190115174343
    core/libtiff/4.0.6/20190115161911
    core/libxau/1.0.8/20190115155357
    core/libxcb/1.12/20190115155652
    core/libxdmcp/1.1.2/20190115155645
    core/libxext/1.3.3/20190115160015
    core/libxfixes/5.0.3/20190115162721
    core/libxi/1.7.9/20190115162726
    core/libxml2/2.9.8/20190115154829
    core/libxmu/1.1.2/20190117175541
    core/libxrandr/1.5.1/20190116233301
    core/libxrender/0.9.10/20190115162752
    core/libxt/1.1.5/20190117175521
    core/make/4.2.1/20190115013626
    core/ncurses/6.1/20190115012027
    core/openssl/1.0.2r/20190305210149
    core/p11-kit/0.23.10/20190117183627
    core/pango/1.40.13/20190617100552
    core/pcre/8.42/20190115012526
    core/pixman/0.34.0/20190416163058
    core/pkg-config/0.29.2/20190115011955
    core/renderproto/0.11.1/20190115162750
    core/xextproto/7.3.0/20190115154203
    core/xlib/1.6.5/20190115155744
    core/xproto/7.0.31/20190115154221
    core/zlib/1.2.11/20190115003728
    guskovd/libxpm/3.5.12/20190702124152
    guskovd/nettle/3.5.1/20190704212841
    guskovd/rust-nightly/1.35.0-2019-05-01/20190702174104
)

pkg_pconfig_dirs=(lib/pkgconfig)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(
    include
    src
)

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
    export CFLAGS='-march=x86-64 -mtune=generic -O2 -pipe -fno-plt'
    export LIBCLANG_PATH=$(pkg_path_for clang)/lib
    cp ${PLAN_CONTEXT}/autogen.sh .
    [[ -x configure ]] || ./autogen.sh
    ./configure --with-gameuser=:games --with-sound=alsa --with-xft --with-modules --with-x-toolkit=gtk3 --without-gconf --with-gsettings --without-makeinfo --infodir=/tmp --prefix="$pkg_prefix"
    make MYCPPFLAGS+=-I$(pkg_path_for libxt)/include
}

do_install() {
    make install PREFIX="$pkg_prefix"
}

do_end() {
    # Clean up the `pwd` link, if we set it up.
    if [[ -n "$_clean_pwd" ]]; then
	rm -fv /bin/pwd
    fi
}

