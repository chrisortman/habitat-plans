# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used in along with `pkg_origin`,
# and `pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
pkg_name=ViennaRNA
pkg_origin=chrisortman
pkg_version="2.3.3"
pkg_source="http://www.tbi.univie.ac.at/RNA/packages/source/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="cf92c05e54dff32c2135433b6ebaa5330c05de02a1ae8b7c3b7a865d42eea514"

pkg_deps=(
  core/glibc
  core/libcxx
)

pkg_build_deps=(
  core/coreutils
  core/make
  core/gcc
  core/perl
)

pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_check() {
  echo CGACGUAGAUGCUAGCUGACUCGAUGC | RNAfold --MEA
}

do_prepare() {
  export ARCHFLAGS="-arch i386 -arch x86_64"
}

do_build() {

  export CPPFLAGS="${CPPFLAGS} ${CFLAGS}"
  ./configure \
      --build=x86_64-linux-gnu \
1     --host=x86_64-linux-gnu \
1     --target=x86_64-linux-gnu \
      --prefix=$pkg_prefix \
      --disable-debug \
      --disable-openmp \
      --without-perl \
      --without-python && make
}
do_strip() {
  return 0
#  do_default_strip
}

# There is no default implementation of this callback. This is called after the
# package has been built and installed. You can use this callback to remove any
# temporary files or perform other post-install clean-up actions.
do_end() {
  return 0
}

