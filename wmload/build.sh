#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=wmload
version=0.9.7
pkgver=1
source[0]=http://http.debian.net/debian/pool/main/w/wmload/wmload_0.9.7.orig.tar.gz
# If there are no patches, simply comment this
#patch[0]=

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

topsrcdir=dockapps-dc20366

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib -lrt"

reg prep
prep()
{
    generic_prep
}

reg build
build()
{
#    generic_build
    setdir ${srcdir}/${topsrcdir}/
    make CC=gcc PREFIX=$prefix
}

reg check
check()
{
    generic_check
}

reg install
install()
{
#    generic_install DESTDIR
    setdir ${srcdir}/${topsrcdir}/
    make CC=gcc PREFIX=${prefix} DESTDIR=${stagedir} install
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
