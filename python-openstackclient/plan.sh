pkg_name=python-openstackclient
pkg_version=1.9.0
pkg_origin=guskovd
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov <guskovd86@mail.ru>"
pkg_license=("Apache-2.0")
pkg_upstream_url=https://github.com/openstack/python-openstackclient
pkg_deps=(
    core/python
)
pkg_build_deps=(
    core/gcc
)

pkg_bin_dirs=(bin)

do_prepare() {
    python -m venv "$pkg_prefix"
    source "$pkg_prefix/bin/activate"
}

do_build() {
    return 0
}

do_install() {
    pip install "$pkg_name==$pkg_version"
    pip freeze > "$pkg_prefix/requirements.txt"
}

do_strip() {
    return 0
}
