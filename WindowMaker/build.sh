#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=WindowMaker
version=0.92.0
pkgver=1
source[0]=http://windowmaker.org/pub/source/release/$topdir-$version.tar.gz
# If there are no patches, simply comment this
#Recent PNG
patch[0]=wm092-001
#Recent GIF
patch[1]=wm092-002

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export CFLAGS="-D__STDC__=1 -fPIC"
export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib"

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
