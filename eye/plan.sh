pkg_name=eye
pkg_origin=chrisortman
pkg_version="0.9.2"
pkg_maintainer="chris ortman <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url=https://github.com/kostya/eye
pkg_build_deps=()
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_deps=(
  core/ruby
  core/busybox-static
  core/glibc

  # This dependency required by 
  # sigar gem ... not sure if it is
  # something transitive it needs or if it really needs perl :(
  core/perl
)
pkg_build_deps=(
  core/coreutils
  core/make
  core/gcc
)

do_prepare() {
  export GEM_HOME="$pkg_prefix"
  build_line "Setting GEM_HOME='$GEM_HOME'"
  export GEM_PATH="$GEM_HOME"
  build_line "Setting GEM_PATH='$GEM_PATH'"
  export CPPFLAGS="${CPPFLAGS} ${CFLAGS}"
}

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_build() {
  return 0
}

do_install() {

  build_line "Installing from RubyGems"
  gem install "$pkg_name" -v "$pkg_version" --no-ri --no-rdoc -- --with-cppflags="-fgnu89-inline"
  # Note: We are not cleaning the gem cache as this artifact
  # is reused by other packages for speed.
  wrap_ruby_bin "$pkg_prefix/bin/eye"
  wrap_ruby_bin "$pkg_prefix/bin/leye"
  wrap_ruby_bin "$pkg_prefix/bin/loader_eye"
}

wrap_ruby_bin() {
  local bin="$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
if test -n "$DEBUG"; then set -x; fi

export GEM_HOME="$GEM_HOME"
export GEM_PATH="$GEM_PATH"
unset RUBYOPT GEMRC

exec $(pkg_path_for ruby)/bin/ruby ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
# pkg_shasum="TODO"
# pkg_deps=(core/glibc)
# pkg_build_deps=(core/make core/gcc)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
# pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="bin/haproxy -f $pkg_svc_config_path/haproxy.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
# pkg_binds=(
#   [database]="port host"
# )
# pkg_binds_optional=(
#   [storage]="port host"
# )
# pkg_interpreters=(bin/bash)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"
