pkg_name=python2-xlib
pkg_distname=${pkg_name}
pkg_version=0.23
pkg_origin=guskovd
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_upstream_url=http://github.com/python-xlib/python-xlib
pkg_dirname=python-xlib-${pkg_version}
pkg_source=https://files.pythonhosted.org/packages/a6/16/921856f28afc5de6886e4297f2bb29088b5ada16b72dac595b143a740380/python-xlib-${pkg_version}.tar.bz2
pkg_shasum=c3deb8329038620d07b21be05673fa5a495dd8b04a2d9f4dca37a3811d192ae4
pkg_deps=(
    core/python2
    guskovd/setuptools # TODO 
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
