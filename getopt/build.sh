#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=getopt
version=2.5
pkgver=2
source[0]=http://ftp.math.utah.edu/pub/${topdir}/${topdir}-${version}.tar.gz
# If there are no patches, simply comment this
#DESTDIR
patch[0]=getopt25-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export CFLAGS=-fPIC
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
