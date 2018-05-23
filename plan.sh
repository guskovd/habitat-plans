pkg_name=guskovd-plans
pkg_origin=guskovd
pkg_version='1.12'
pkg_description="guskovd habitat plans"
pkg_maintainer='guskovd'
pkg_upstream_url="https://github.com/guskovd/habitat-plans"

pkg_hab_shell_interpreter="bash"

pkg_deps=(
    core/bash
    core/coreutils
    core/gawk
    core/which
    core/hab
    core/grep
    core/sed
    core/sudo
    core/make
    core/git
)

do_shell() {
    . ~/.bashrc
    unset HAB_CACHE_KEY_PATH
    export HAB_ORIGIN="guskovd"
}

do_build() {
    return 0
}

do_install() {
    return 0
}

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
