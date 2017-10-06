pkg_name=mfold
pkg_origin=chrisortman
pkg_version="3.6"
pkg_maintainer="Chris Ortman <nospam@uiowa.edu>"
pkg_license=('Academic License')
pkg_source="http://unafold.rna.albany.edu/download/${pkg_name}-${pkg_version}.tar.gz"
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="153bb2870fa9038bd27456695659c17f12ccf13bda38e8e71740a15f625bb426"
pkg_bin_dirs=(bin)
pkg_deps=(
  core/glibc
  core/libcxx
  core/busybox
)

pkg_build_deps=(
  core/coreutils
  core/make
  core/gcc
)

do_prepare() {
 export CXXFLAGS="$CXXFLAGS $CFLAGS"
 export LD_LIBRARY_PATH=$(pkg_path_for gcc)/lib
 export LIBRARY_PATH="$(pkg_path_for gcc)/lib:$(pkg_path_for glibc)/lib"
}

do_build() {
  ./configure --prefix=$pkg_prefix CC=gcc CXX=g++
  make

}

do_install() {
  do_default_install
  for f in filter-sort h-num mfold mfold_quik reformat-seq.sh myps2img.bash
  do
    fix_interpreter "$pkg_prefix/bin/$f" core/busybox bin/bash
  done

}
