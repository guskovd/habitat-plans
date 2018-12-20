pkg_name=mdbook
pkg_origin=guskovd
pkg_version=0.2.1
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov"
pkg_bin_dirs=(bin)
pkg_upstream_url="https://github.com/rust-lang-nursery/mdBook"
pkg_description="Create book from markdown files. Like Gitbook but implemented in Rust "

pkg_deps=(
    core/glibc
    core/gcc-libs
)

pkg_build_deps=(
    core/rust
)

do_build() {
    return 0
}

do_install() {
    cargo install mdbook --root "${pkg_prefix}" --vers "${pkg_version}" -j"$(nproc)" --verbose
}

do_download() {
    return 0
}
