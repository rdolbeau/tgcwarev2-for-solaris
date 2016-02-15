#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=libXft
version=2.3.2
pkgver=1
source[0]=http://xorg.freedesktop.org/releases/individual/lib/$topdir-$version.tar.gz
# If there are no patches, simply comment this
patch[0]=libXft232-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export CFLAGS=-std=c89
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
