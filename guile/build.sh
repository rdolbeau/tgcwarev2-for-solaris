#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=guile
version=1.8.8
pkgver=1
source[0]=ftp://ftp.gnu.org/gnu/${topdir}/${topdir}-${version}.tar.gz
# If there are no patches, simply comment this
#missing defines (ipv6?)
#patch[0]=guile2011-001
#missing lround
#patch[1]=guile2011-002

patch[0]=fix-solaris-stackbase-detection.patch
#no isinf, misdetected
patch[1]=guile188-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

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
