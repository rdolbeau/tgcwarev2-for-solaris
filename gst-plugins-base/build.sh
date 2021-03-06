#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=gst-plugins-base
version=1.0.3
pkgver=1
source[0]=http://gstreamer.freedesktop.org/src/${topdir}/${topdir}-${version}.tar.xz
# If there are no patches, simply comment this
#BSD ioctls
patch[0]=gst-plugins-base103-001
#rfc2553
case "${build_arch}-${gnu_os_ver}" in
    sparc-2.7)
	patch[1]=gst-plugins-base103-002
	patch[2]=gst-plugins-base103-003
	patch[3]=gst-plugins-base103-004
        ;;
    *)
	patch[1]=""
        patch[2]=""
        patch[3]=""
        ;;
esac
#no xkb
patch[4]=gst-plugins-base103-005
#shell issues
patch[5]=gst-plugins-base103-006

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
