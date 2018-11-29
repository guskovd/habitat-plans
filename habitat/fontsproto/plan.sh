pkg_name=fontsproto
pkg_origin=guskovd
pkg_version=2.1.3
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_description="X11 font extension wire protocol"
pkg_upstream_url="https://xorg.freedesktop.org/"
license=('custom')
pkg_source="https://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="259046b0dd9130825c4a4c479ba3591d6d0f17a33f54e294b56478729a6e5ab8"
pkg_deps=(
    core/glibc
    xorg/libXt/1.1.5/20170607234359
    xorg/libxext/1.3.3/20170607234437
    xorg/xlib/1.6.5/20170607234030
    xorg/libxcb/1.12/20170607233918
    xorg/libXau/1.0.8/20170607233814
    xorg/libXdmcp/1.1.2/20170607233905
    xorg/libice/1.0.9/20170607233827
    xorg/libsm/1.2.2/20170607233852
)
pkg_build_deps=(
    core/xproto
    core/gcc
    core/make
    core/pkg-config
    xorg/xextproto/7.3.0/20170607233708
    xorg/xproto/7.0.31/20170607233653
    xorg/kbproto/1.0.7/20170607233756
    xorg/libpthread-stubs/0.4/20170607233627
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

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

do_build() {
    ls -lha
}

do_check() {
    make check
}

