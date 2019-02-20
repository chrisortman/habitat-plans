pkg_name=haproxy-front
pkg_origin=chrisortman
pkg_version="0.1.0"
pkg_maintainer="Chris Ortman <nospam@habitat.sh>"
pkg_license=("MIT")
pkg_deps=(core/haproxy)
pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf -db"
pkg_svc_user=root
pkg_svc_group=root

do_download() {
  return 0;
}
do_verify() {
  return 0;
}
do_build() {
  return 0;
}
do_install() {
  return 0;
}
