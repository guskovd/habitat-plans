pkg_name=terminus-font
pkg_origin=guskovd
pkg_version=4.46
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_description="Monospace bitmap font (for X11 and console)"
pkg_upstream_url="https://sourceforge.net/projects/terminus-font/"
pkg_license=('GPL2' 'custom:OFL')
pkg_source="https://downloads.sourceforge.net/project/${pkg_name}/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="4e29433e5699b76df1f5c9a96f1228cccf8ea8a16791cfef063f2b8506c75bcd"
pkg_deps=(
    core/fontconfig
)
pkg_build_deps=(
    core/gcc
    core/make
    core/python
)

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
    chmod +x "$HAB_CACHE_SRC_PATH/$pkg_dirname/"
}

do_build() {
    ./configure --prefix=/usr --x11dir=/usr/share/fonts/misc --psfdir=/usr/share/kbd/consolefonts
    make
}

do_install() {
    return 0
}
