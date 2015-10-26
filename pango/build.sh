#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=pango
baseversion=1.31
version=${baseversion}.2
pkgver=1
source[0]=http://ftp.gnome.org/pub/gnome/sources/${topdir}/${baseversion}/$topdir-$version.tar.xz
# If there are no patches, simply comment this
#Adjust to HarfBuzz 0.9.7 API
patch[0]=pango1312-001
#missng Xfuncproto.h
patch[1]=pango1312-002

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

configure_args+=(--with-libiconv=gnu)

export CFLAGS="-D__STDC__=1 -fPIC"
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
