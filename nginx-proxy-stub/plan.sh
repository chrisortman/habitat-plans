pkg_origin=chrisortman
pkg_name=nginx-proxy-stub
pkg_description="Used to setup and nginx instance with canned responses to gest haproxy config"
pkg_version="0.1.0"
pkg_maintainer="Chris Ortman <nospam@habitat.sh>"
pkg_license=("MIT")
pkg_deps=(core/nginx)
pkg_svc_user="root"
pkg_svc_run="nginx -c ${pkg_svc_config_path}/nginx.conf"

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_build() {
  return 0;
}

do_install() {
  return 0;
}
