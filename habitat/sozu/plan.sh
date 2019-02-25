pkg_name=sozu
pkg_origin=guskovd
pkg_version=0.11.0
pkg_license=('Apache-2.0')
pkg_maintainer="Danil Guskov"
pkg_bin_dirs=(bin ctl)
pkg_upstream_url="https://github.com/sozu-proxy/sozu"
pkg_description="Sōzu HTTP reverse proxy, configurable at runtime, fast and safe, built in Rust. It will be awesome when it will be ready. Not So Secret Project! Ping us on gitter to know more https://www.sozu.io/"

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
    cargo install sozu --root "${pkg_prefix}" --vers "${pkg_version}" -j"$(nproc)" --verbose
}

do_download() {
    return 0
}
