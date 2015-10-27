#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=gdk-pixbuf
baseversion=2.26
version=${baseversion}.5
pkgver=2
source[0]=http://ftp.gnome.org/pub/GNOME/sources/${topdir}/${baseversion}/${topdir}-${version}.tar.xz
# If there are no patches, simply comment this
#no ceilf in libm
patch[0]=gdk-pixbuf2265-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib"

configure_args+=(--disable-xkb)

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
