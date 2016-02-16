#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=gnu-ghostscript
version=9.14.0
pkgver=1
source[0]=ftp://ftp.gnu.org/gnu/ghostscript/${topdir}-${version}.tar.xz
# If there are no patches, simply comment this
patch[0]=gnu-ghostscript9140-001-lrintf

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

#configure_args+=

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib"
export PYTHON=$prefix/bin/python2.7

reg prep
prep()
{
    generic_prep
}

reg build
build()
{
    generic_build
}

reg check
check()
{
    generic_check
}

reg install
install()
{
    generic_install DESTDIR
    doc COPYING AUTHORS NEWS
}

reg pack
pack()
{
    generic_pack
}

reg distclean
distclean()
{
    clean distclean
}

###################################################
# No need to look below here
###################################################
build_sh $*
