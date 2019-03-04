pkg_name=mdbook
pkg_origin=guskovd
pkg_version=0.2.1
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov"
pkg_bin_dirs=(bin)
pkg_upstream_url="https://github.com/rust-lang-nursery/mdBook"
pkg_description="Create book from markdown files. Like Gitbook but implemented in Rust "

pkg_build_deps=(
    core/rust
    core/gcc
    core/pkg-config
    core/make
    core/musl
)

do_prepare() {
    export LD_LIBRARY_PATH=$(pkg_path_for gcc)/lib
    export rustc_target="x86_64-unknown-linux-musl"
    build_line "Setting rustc_target=$rustc_target"
}

do_build() {
    cargo install --target=$rustc_target mdbook --root "${pkg_prefix}" --vers "${pkg_version}"
}

do_install() {
    return 0
}

do_download() {
    return 0
}
