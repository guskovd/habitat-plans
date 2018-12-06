$pkg_name="geckodriver"
$pkg_origin="qago"
$pkg_version="0.23.0"
$pkg_license=@("LGPL")
$pkg_upstream_url="https://github.com/mozilla/geckodriver"
$pkg_description="geckodriver"
$pkg_maintainer="QAGO Maintainers"
$pkg_source="https://github.com/mozilla/geckodriver/releases/download/v$pkg_version/geckodriver-v$pkg_version-win64.zip"
$pkg_shasum="deaa8596bcafacf53583af0c86b1033cd97b2c8dbc85e957224fe7dceee81590"
$pkg_filename="geckodriver-v$pkg_version-win64.zip"
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

$pkg_deps=@(
    "core/hab/0.65.0",
    "qago/powershell"
)

function Invoke-Unpack {
    mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin"
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin"
}

function Invoke-Install {
    Copy-Item * "$pkg_prefix" -Recurse -Force
    cp "$PLAN_CONTEXT/../pwsh-scripts/syncTaskRunner.ps1" "$pkg_prefix/lib"
}
