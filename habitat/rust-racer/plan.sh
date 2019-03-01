pkg_name=rust-racer
pkg_origin=guskovd
pkg_version=2.1.19
pkg_license=('BSD')
pkg_bin_dirs=(bin)
pkg_maintainer="Danil Guskov"
pkg_upstream_url="https://github.com/racer-rust/racer"
pkg_description="Rust Code Completion utility "

pkg_build_deps=(
    guskovd/rust-nightly
    core/gcc
    core/pkg-config
    core/make
    core/musl
    # core/glibc
    # core/gcc-libs
)

do_prepare() {
    export LD_LIBRARY_PATH=$(pkg_path_for gcc)/lib
    export rustc_target="x86_64-unknown-linux-musl"
    build_line "Setting rustc_target=$rustc_target"
}

do_build() {
    cargo -Z unstable-options install --target=$rustc_target racer --root "${pkg_prefix}" --vers "${pkg_version}"
}

do_install() {
    return 0
}

do_download() {
    return 0
}

# do_setup_environment() {
#     push_runtime_env LD_LIBRARY_PATH "$(pkg_path_for core/gcc-libs)/lib"
# }
