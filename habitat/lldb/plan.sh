pkg_name=lldb
pkg_origin=guskovd
pkg_version=7.0.0
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url="http://llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="${pkg_name}-${pkg_version}.src.tar.xz"
pkg_source="http://releases.llvm.org/$pkg_version/lldb-$pkg_version.src.tar.xz"
pkg_shasum="7ff6d8fee49977d25b3b69be7d22937b92592c7609cf283ed0dcf9e5cd80aa32"
pkg_deps=(
    core/coreutils
    core/gcc-libs
    core/libffi
    core/python2
    core/zlib
    core/ncurses/6.1/20190115012027
    core/libedit
    core/clang
    core/swig
    core/doxygen
    core/clang-tools-extra
    core/llvm
)
pkg_build_deps=(
    core/cmake
    core/diffutils
    core/gcc
    core/ninja
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_begin() {
    export HAB_ENV_CMAKE_FIND_ROOT_PATH_SEPARATOR=";"
    export HAB_ENV_CMAKE_FIND_ROOT_PATH_TYPE="aggregate"
}

do_setup_environment() {
    set_buildtime_env BUILD_DIR "_build"

    # this allows cmake users to utilize `CMAKE_FIND_ROOT_PATH` to find various cmake configs
    push_runtime_env CMAKE_FIND_ROOT_PATH "${pkg_prefix}/lib/cmake/lldb"
}

do_unpack() {
    build_line "Unpacking $pkg_filename to custom cache dir"
    local source_file="$HAB_CACHE_SRC_PATH/$pkg_filename"
    local unpack_dir="${pkg_prefix}/src"
    mkdir -p "$unpack_dir"
    pushd "$unpack_dir" > /dev/null || exit 1
    tar xf "$source_file" --strip 1 --no-same-owner
    popd > /dev/null || exit 1
}

do_prepare() {
    mkdir -p "${BUILD_DIR}"

    # fix the interpreters in the `src`
    _fix_interpreter_in_path "$pkg_prefix/src" '*.py' core/python2 bin/python
    _fix_interpreter_in_path "$pkg_prefix/src" '*.py' core/coreutils bin/env
    _fix_interpreter_in_path "$pkg_prefix/src" '*.sh' core/coreutils bin/env
}

do_build() {
    _LIBFFI_PATH="$(pkg_path_for libffi)"

    pushd "${BUILD_DIR}" || exit 1
    cmake \
	-DLLVM_ENABLE_PROJECTS='clang;lldb' \
	-DLLVM_TABLEGEN=${pkg_prefix}/bin/llvm-tblgen \
	-DCMAKE_PREFIX_PATH=$(pkg_path_for ncurses) \
	-DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DPYTHON_LIBRARY=$(pkg_path_for python2)/lib/libpython2.7.so \
	-DPYTHON_INCLUDE_DIR=$(pkg_path_for python2)/include \
	-DCURSES_LIBRARY=$(pkg_path_for ncurses)/lib/libncurses++w.so.6.1 \
	-DCURSES_INCLUDE_PATH=$(pkg_path_for ncurses)/include \
	-DLLVM_LINK_LLVM_DYLIB=ON \
	-Dlibedit_INCLUDE_DIRS=$(pkg_path_for libedit)/include \
	-Dlibedit_LIBRARIES=$(pkg_path_for libedit)/lib \
	-G "Ninja" \
	"${pkg_prefix}/src"

    # ninja defaults to using 8 jobs. on machines with limited resources this becomes
    # problematic causing things not to be built and run.
    ninja -j"$(nproc --ignore=1)"

    # used by other clang tools
    install compile_commands.json "${pkg_prefix}/src"
    popd || exit 1
}

do_check() {
    pushd "${BUILD_DIR}" || exit 1

    # ninja defaults to using 8 jobs. on machines with limited resources this becomes
    # problematic causing things not to be built and run.
    ninja -j"$(nproc --ignore=1)" check-all
    popd || exit 1
}

do_install() {
    pushd "${BUILD_DIR}" || exit 1
    ninja install
    popd || exit 1
}

do_strip() {
    build_line "Stripping unneeded symbols from binaries and libraries"
    # we need to skip the src folder
    for folder in bin include lib; do
	find "$pkg_prefix/$folder" -type f -perm -u+w -print0 2> /dev/null \
	    | while read -rd '' f; do
            case "$(file -bi "$f")" in
		*application/x-executable*) strip --strip-all "$f";;
		*application/x-sharedlib*) strip --strip-unneeded "$f";;
		*application/x-archive*) strip --strip-debug "$f";;
		*) continue;;
            esac
	done
    done
}

# private #
_fix_interpreter_in_path() {
    local path=$1
    local fileending=$2
    local pkg=$3
    local int=$4

    # shellcheck disable=SC2016
    # I need these to be evaluated at exec time
    find "$path" -name "$fileending" -type f \
	 -exec grep -Iq . {} \; \
	 -exec sh -c 'head -n 1 "$1" | grep -q "$2"' _ {} "$int" \; \
	 -exec sh -c 'echo "$1"' _ {} \; > /tmp/fix_interpreter_in_path_list

    grep -v '^ *#' < /tmp/fix_interpreter_in_path_list | while IFS= read -r line
    do
	fix_interpreter "$line" "$pkg" "$int"
    done
    rm -rf /tmp/fix_interpreter_in_path_list
}
