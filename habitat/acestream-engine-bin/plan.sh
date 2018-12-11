pkg_name=acestream-engine-bin
pkg_origin=guskovd
pkg_version="3.1.16"
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_source="http://dl.acestream.org/linux/acestream_${pkg_version}_ubuntu_16.04_x86_64.tar.gz"
pkg_shasum="452bccb8ae8b5ff4497bbb796081dcf3fec2b699ba9ce704107556a3d6ad2ad7"
pkg_dirname="acestream_${pkg_version}_ubuntu_16.04_x86_64"

pkg_deps=(
    core/net-tools
    core/openssl
    core/python2
    core/virtualenv
    core/zlib
    core/swig
    core/bash
    core/gawk
)

pkg_build_deps=(
    core/gcc
)

pkg_bin_dirs=(
    bin
    venv/bin
)
pkg_lib_dirs=(
    lib
    venv/lib
)

do_setup_environment() {
    push_runtime_env PYTHONPATH "${pkg_prefix}/venv/lib/python2.7/site-packages"
}

do_prepare() {
    virtualenv "$pkg_prefix/venv"
    source "$pkg_prefix/venv/bin/activate"
}

do_install() {
    cp -rf $HAB_CACHE_SRC_PATH/$pkg_dirname/* $pkg_prefix/bin
    rm $pkg_prefix/bin/lib/lxml-3.7.2-py2.7-linux-x86_64.egg # lxml fix
    export SWIG_FEATURES="-cpperraswarn -includeall -I$($HAB_BIN pkg path core/openssl)/include"
    source "$pkg_prefix/venv/bin/activate"
    pip install -r $PLAN_CONTEXT/requirements.txt
    pip freeze > $PLAN_CONTEXT/requirements.txt
}

do_build() {
    return 0
}
