pkg_name=python2-typing
pkg_distname=${pkg_name}
pkg_version=3.6.4
pkg_origin=guskovd
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_upstream_url=http://github.com/python/typing
pkg_dirname=typing-${pkg_version}
pkg_source=https://files.pythonhosted.org/packages/ec/cc/28444132a25c113149cec54618abc909596f0b272a74c55bab9593f8876c/typing-${pkg_version}.tar.gz
pkg_shasum=d400a9344254803a2368533e4533a4200d21eb7b6b729c173bc38201a74db3f2
pkg_deps=(
    core/python2
)

pkg_env_sep=(
    ['PYTHONPATH']=':'
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
    python setup.py build
}

do_setup_environment() {
    push_runtime_env PYTHONPATH "$(pkg_path_for python2)/lib/python2.7/site-packages"
    push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python2.7/site-packages"
}

do_prepare() {
    mkdir -p "${pkg_prefix}/lib/python2.7/site-packages"
}

do_install() {
    python setup.py install --prefix="$pkg_prefix" --optimize=1 --skip-build
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
