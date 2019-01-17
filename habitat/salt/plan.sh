pkg_name=salt
pkg_version=v2018.3.3
pkg_origin=guskovd
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_upstream_url=https://github.com/saltstack/salt

pkg_deps=(
    core/python2
    core/virtualenv
    core/zeromq
    core/openssl
)
pkg_build_deps=(
    core/gcc
    core/patch
    core/diffutils
)

pkg_bin_dirs=(bin)

do_prepare() {
    virtualenv "$pkg_prefix"
    source "$pkg_prefix/bin/activate"
}

do_build() {
    return 0
}

do_install() {
    pip install "$pkg_name==$pkg_version"
    pip freeze > "$pkg_prefix/requirements.txt"
    pushd $pkg_prefix/lib/python2.7/site-packages/salt/utils
    patch -p1 < "$PLAN_CONTEXT/rsax931.py.patch"
}

do_strip() {
    return 0
}

do_setup_environment() {
    push_runtime_env LD_LIBRARY_PATH "$(pkg_path_for core/openssl)/lib"
}
