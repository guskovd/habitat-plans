$pkg_name="iedriver"
$pkg_origin="guskovd"
$pkg_version="x64_3.14.0"
$pkg_license=@("LGPL")
$pkg_upstream_url="http://www.seleniumhq.org"
$pkg_description="iedriver"
$pkg_maintainer="Danil Guskov"
$pkg_source="http://selenium-release.storage.googleapis.com/3.14/IEDriverServer_$pkg_version.zip"
$pkg_shasum="5e94943c2d31a285217ac8793e970339c0f87e4bbbc757f55aa293643741aed3"
$pkg_filename="IEDriverServer_x64_$pkg_version.0.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin"
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin"
}

function Invoke-Install {
    Copy-Item * "$pkg_prefix" -Recurse -Force
}
