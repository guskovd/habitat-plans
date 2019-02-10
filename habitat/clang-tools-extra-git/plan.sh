source ../clang/plan.sh

pkg_name=clang-tools-extra-git
pkg_origin=guskovd
pkg_version=8214828fc69893248caf7291d73b70690e4f6987

llvm_pkg_version=8c2a52db8a1ab1287833bc6b6c7a229a4a6c0ad0

pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_source="https://github.com/llvm-mirror/clang-tools-extra/archive/$pkg_version.tar.gz"

pkg_shasum="13ecfbd639711f53b2a8f0382e43bd8037b5b24e4e04c7c2f9d77d117eca488e"

do_unpack() {
  # The tarball's structure has `.src` as part of the base directory.
  # This reimplements a large portion of the default unpack, only to
  # add `--strip` to the tar command.
  # There may be some more awesome way to do this - I don't know that yet.
  local source_file=$HAB_CACHE_SRC_PATH/$pkg_filename
  local unpack_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}

  # Download Clang frontend and place it in the correct place
  build_line "Unpacking Clang FrontEnd Source to custom cache dir"
  download_file https://github.com/llvm-mirror/llvm/archive/$llvm_pkg_version.tar.gz \
    cfe-${pkg_version}.src.tar.xz \
    135f6c9b0cd2da1aff2250e065946258eb699777888df39ca5a5b4fe5e23d0ff

  local clang_src_dir="$unpack_dir"
  mkdir -p "$clang_src_dir"
  pushd "$clang_src_dir" > /dev/null || exit
  tar xf "$HAB_CACHE_SRC_PATH/cfe-${pkg_version}.src.tar.xz" --strip 1 --no-same-owner
  popd > /dev/null || exit

  # Unpack Clang-Tools-Extra and place it in the correct place
  build_line "Unpacking Clang-Tools-Extra to custom cache dir"
  local clang_tools_extra_src_dir="$unpack_dir/tools/extra"
  mkdir -p "$clang_tools_extra_src_dir"
  pushd "$clang_tools_extra_src_dir" > /dev/null || exit
  tar xf "$source_file" --strip 1 --no-same-owner
  popd > /dev/null || exit
}


pkg_build_deps=(
  guskovd/llvm-git
  core/ninja
  core/cmake
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/python2
)
