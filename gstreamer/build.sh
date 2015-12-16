#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=gstreamer
version=1.0.3
pkgver=1
source[0]=http://${topdir}.freedesktop.org/src/${topdir}/${topdir}-${version}.tar.xz
# If there are no patches, simply comment this
# missing floorf
patch[0]=gstreamer103-001
patch[1]=gstreamer103-002

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

#configure_args+=

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib -lsocket -lnsl"
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
