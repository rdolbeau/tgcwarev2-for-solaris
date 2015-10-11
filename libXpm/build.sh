#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=libXpm
version=3.4g
pkgver=1
#source[0]=http://xorg.freedesktop.org/releases/individual/lib/${topdir}-${version}.tar.gz
source[0]=ftp://ftp.x.org/contrib/libraries/libXpm-4.7.tar.gz
# If there are no patches, simply comment this
#patch[0]=

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

topsrcdir=xpm-${version}

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
    export PATH=$PATH:/usr/openwin/bin
    xmkmf -a
    make CC=gcc CCOPTIONS=-O2 PICFLAGS=-fPIC
}

reg check
check()
{
    generic_check
}

reg install
install()
{
    setdir ${srcdir}/${topsrcdir}/
    export PATH=$PATH:/usr/openwin/bin
    make BINDIR=${prefix}/bin INCROOT=${prefix}/include USRLIBDIR=${prefix}/lib SHLIBDIR=${prefix}/lib MANPATH=${prefix}/share/man DESTDIR=${stagedir} install
    chmod 755 ${stagedir}/${prefix}/bin/*  ${stagedir}/${prefix}/lib/*.so*
    doc COPYRIGHT
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
