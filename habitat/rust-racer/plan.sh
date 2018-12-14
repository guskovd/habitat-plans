pkg_name=rust-racer
pkg_origin=guskovd
pkg_version=2.1.16
pkg_license=('BSD')
pkg_bin_dirs=(bin)
pkg_maintainer="Danil Guskov"
pkg_upstream_url="https://github.com/racer-rust/racer"
pkg_description="Rust Code Completion utility "

pkg_deps=(core/glibc core/gcc-libs core/openssl)
pkg_build_deps=(
    guskovd/rust-nightly
    core/gcc
    core/pkg-config
    core/openssl
    core/make
)

do_build() {
    cargo -Z unstable-options install racer --root "${pkg_prefix}" --vers "${pkg_version}"
}

do_install() {
    return 0
}

do_download() {
    return 0
}

do_setup_environment() {
    push_runtime_env LD_LIBRARY_PATH "$(pkg_path_for core/gcc-libs)/lib"
}
