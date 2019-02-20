pkg_name=rustup
pkg_origin=guskovd
pkg_version=beab5ac2bd6e25e1bb756e14404ed81a6cc49e9e
pkg_license=('BSD')
pkg_bin_dirs=(bin)
pkg_maintainer="Danil Guskov"
pkg_shasum="ae744cec4fb628df4b82b49bd3e7d3f0a22485d3f6f6a04cd9504f90081bb2f8"
pkg_upstream_url="https://github.com/rust-lang/rustup.rs"
pkg_source="https://github.com/rust-lang/rustup.rs/archive/${pkg_version}.tar.gz"
pkg_dirname=rustup.rs-${pkg_version}
pkg_description="the Rust toolchain installer"

pkg_build_deps=(
    core/gcc-libs
    core/openssl
    core/rust
    core/pkg-config
    core/make
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
    cargo install --root "${pkg_prefix}" --vers "${pkg_version}"
}

do_setup_environment() {
    push_runtime_env LD_LIBRARY_PATH "$(pkg_path_for core/gcc-libs)/lib"
}
