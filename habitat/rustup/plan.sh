pkg_name=rustup
pkg_origin=guskovd
pkg_version=1.19.0
pkg_license=('BSD')
pkg_bin_dirs=(bin)
pkg_maintainer="Danil Guskov"
pkg_shasum="b5b2c1c369e44f0c6529169f0c4e680c257a13d220b643a31686033fff2a5983"
pkg_upstream_url="https://github.com/rust-lang/rustup.rs"
pkg_source="https://github.com/rust-lang/rustup.rs/archive/${pkg_version}.tar.gz"
pkg_dirname=rustup.rs-${pkg_version}
pkg_description="the Rust toolchain installer"

pkg_build_deps=(
    core/openssl
    core/rust
    core/pkg-config
    core/make
)
pkg_deps=(
    core/gcc-libs
)

do_prepare() {
    export OPENSSL_LIB_DIR=$(pkg_path_for openssl)/lib
    export OPENSSL_INCLUDE_DIR=$(pkg_path_for openssl)/include
    export OPENSSL_STATIC=true
}

do_build() {
    cargo build --release --features no-self-update --bin rustup-init
}

do_install() {
    cargo install --root "${pkg_prefix}" --path "${CACHE_PATH}" --verbose
}

# do_setup_environment() {
#     push_runtime_env LD_LIBRARY_PATH "$(pkg_path_for core/gcc-libs)/lib"
# }

do_clean() {
    # Prevent rm -rf "$CACHE_PATH"
    return 0
}
