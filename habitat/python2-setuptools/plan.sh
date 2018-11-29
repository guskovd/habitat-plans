pkg_name=python2-setuptools
pkg_distname=${pkg_name}
pkg_version=39.2.0
pkg_origin=guskovd
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_upstream_url=http://github.com/pypa/setuptools
pkg_dirname=setuptools-${pkg_version}
pkg_source=https://files.pythonhosted.org/packages/1a/04/d6f1159feaccdfc508517dba1929eb93a2854de729fa68da9d5c6b48fa00/setuptools-${pkg_version}.zip
pkg_shasum=f7cddbb5f5c640311eb00eab6e849f7701fa70bf6a183fc8a2c33dd1d1672fb2
pkg_deps=(
    core/python2
)

pkg_env_sep=(
    ['PYTHONPATH']=':'
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
    ls ../ -lha
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
