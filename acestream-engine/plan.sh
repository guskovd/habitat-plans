pkg_name=acestream-engine
pkg_origin=guskovd
pkg_version="3.1.16"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="http://dl.acestream.org/linux/acestream_${pkg_version}_ubuntu_16.04_x86_64.tar.gz"
pkg_shasum="452bccb8ae8b5ff4497bbb796081dcf3fec2b699ba9ce704107556a3d6ad2ad7"
pkg_deps=(
    core/python2
)
pkg_build_deps=(

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

do_install() {
    return 0
}

do_build() {
    return 0
}
