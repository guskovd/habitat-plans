pkg_name=python2-m2crypto
pkg_distname=${pkg_name}
pkg_version=0.23.0
pkg_origin=guskovd
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_upstream_url=http://github.com/m2crypto/m2crypto
pkg_dirname=M2Crypto-0.23.0
pkg_source=https://files.pythonhosted.org/packages/d6/2c/cb926a8eb4bed2b6d4bea25b3af898440cdfc18e6a0ddc224b9f85010333/M2Crypto-0.23.0.tar.gz
pkg_shasum=1ac3b6eafa5ff7e2a0796675316d7569b28aada45a7ab74042ad089d15a9567f
pkg_deps=(
    core/openssl
    core/python2
)
pkg_build_deps=(
    core/swig
    core/gcc
)

pkg_env_sep=(
    ['PYTHONPATH']=':'
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
    export SWIG_FEATURES="-cpperraswarn -includeall -I$($HAB_BIN pkg path core/openssl)/include"
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
