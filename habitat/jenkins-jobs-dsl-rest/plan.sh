pkg_origin=guskovd
pkg_name=jenkins-job-dsl-rest
pkg_version=master
pkg_description="Jenkins Jobs Dsl REST cli"
pkg_maintainer='Danil Guskov'
pkg_license=('LGPL-2.1')
pkg_source=https://github.com/sheehan/job-dsl-rest-example/archive/master.tar.gz 
pkg_upstream_url=https://github.com/sheehan/job-dsl-rest-example
pkg_shasum=c33a2a08cbe6e2036542d51f6df02973bc23e86422ff6ccfea4d8eba11f7d354
pkg_dirname=job-dsl-rest-example-${pkg_version}
pkg_deps=(
    core/jre8
    core/gradle
    core/hab
    core/bash
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
    mkdir -p $pkg_prefix/lib/
    mkdir -p $pkg_prefix/bin/
    cp -rf * $pkg_prefix/lib/
    pushd $pkg_prefix/lib/
    gradle build
    chmod -R 777 build
    rm .gradle -rf
}

do_install() {
    cp $PLAN_CONTEXT/bin/jjdsl $pkg_prefix/bin/
}

_install_dependency() {
    local dep="${1}"
    if [[ -z "${NO_INSTALL_DEPS:-}" ]]; then

    # Enable --ignore-local if invoked with HAB_FEAT_IGNORE_LOCAL in
    # the environment, set to either "true" or "TRUE" (features are
    # not currently enabled by the mere presence of an environment variable)
    if [[ "${HAB_FEAT_IGNORE_LOCAL:-}" = "true" ||
              "${HAB_FEAT_IGNORE_LOCAL:-}" = "TRUE" ]]; then
        IGNORE_LOCAL="--ignore-local"
    fi
    $HAB_BIN pkg path "$dep" || $HAB_BIN install -u $HAB_BLDR_URL --channel $HAB_BLDR_CHANNEL ${IGNORE_LOCAL:-} "$dep" || {
      if [[ "$HAB_BLDR_CHANNEL" != "$FALLBACK_CHANNEL" ]]; then
        build_line "Trying to install '$dep' from '$FALLBACK_CHANNEL'"
        $HAB_BIN install -u $HAB_BLDR_URL --channel "$FALLBACK_CHANNEL" ${IGNORE_LOCAL:-} "$dep" || true
      fi
    }
  fi
  return 0
}
