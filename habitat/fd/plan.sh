pkg_name=fd
pkg_origin=guskovd
pkg_version=7.2.0
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov"
pkg_bin_dirs=(bin)
pkg_upstream_url="https://github.com/sharkdp/fd"
pkg_description="A simple, fast and user-friendly alternative to 'find'"

# pkg_deps=(
#     core/glibc
#     core/gcc-libs
# )

pkg_build_deps=(
    core/glibc
    core/gcc
    core/gcc-libs
    core/rust
)

do_build() {
    return 0
}

do_install() {
    cargo install fd-find --root "${pkg_prefix}" --vers "${pkg_version}" -j"$(nproc)" --verbose
}

do_download() {
    return 0
}
