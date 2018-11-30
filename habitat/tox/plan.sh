pkg_name=tox
pkg_origin=qago
pkg_version=3.2.1
pkg_description="tox automation project"
pkg_upstream_url="https://tox.readthedocs.io"
ppkg_maintainer='QAGO Maintainers'
pkg_license=('LGPL-2.1')
pkg_source="https://files.pythonhosted.org/packages/ad/fe/55b245f4d4b30baafee29fe0f78dcd9eee89e0e222f4b22789f0fb84ae07/tox-3.2.1.tar.gz"
pkg_shasum=eb61aa5bcce65325538686f09848f04ef679b5cd9b83cc491272099b28739600

pkg_deps=(
    core/python/3.7.0
)

pkg_build_deps=(
  core/make
  core/gcc
)

pkg_bin_dirs=(bin)


do_build() {
    return 0
}

do_install() {
    python="$(pkg_path_for core/python)/bin/python"
    python_version="$($python -c 'import sys; print("python{}.{}".format(sys.version_info.major,sys.version_info.minor))')"
    mkdir -p "${pkg_prefix}/lib/${python_version}/site-packages"
    export PYTHONPATH="${pkg_prefix}/lib/${python_version}/site-packages"
    python setup.py install --prefix="$pkg_prefix" --optimize=1 --skip-build
    sed -i "2iimport sys; sys.path.append(\"$PYTHONPATH\")" "$pkg_prefix/bin/tox"
}
