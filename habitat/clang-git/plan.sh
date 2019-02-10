source ../clang/plan.sh

pkg_name=clang-git
pkg_origin=guskovd
pkg_version=fdd6b2ea2ac03f09aaf71aa8d3301936cef0fee5

pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_source="https://github.com/llvm-mirror/clang/archive/$pkg_version.tar.gz"

pkg_shasum="a45b62dde5d7d5fdcdfa876b0af92f164d434b06e9e89b5d0b1cbc65dfe3f418"
clang_tools_extra_shasum="937c5a8c8c43bc185e4805144744799e524059cac877a44d9063926cd7a19dbe"

pkg_build_deps=(
  guskovd/llvm-git
  core/perl
  core/cmake
  core/diffutils
  core/ninja
)

