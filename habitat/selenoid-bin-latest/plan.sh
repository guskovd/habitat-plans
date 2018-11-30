. ../selenoid-bin/plan.sh
. ../build-scripts/functions.sh

pkg_version=_set_from_git_

pkg_build_deps=(
    core/curl
)

do_verify() {
    return 0
}

do_before() {
    update_pkg_version
}

update_pkg_version() {
    pkg_version=$(get_latest_release "aerokube/selenoid")
    echo hello
    curl "https://api.github.com/repos/aerokube/selenoid/releases/latest?access_token=${GITHUB_TOKEN}"
    echo hello
    pkg_source=https://github.com/aerokube/selenoid/releases/download/${pkg_version}/selenoid_linux_amd64
    pkg_prefix=$HAB_PKG_PATH/${pkg_origin}/${pkg_name}/${pkg_version}/${pkg_release}
}
