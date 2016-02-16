#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=libXaw3d
version=1.5E
pkgver=1
source[0]=http://pkgs.fedoraproject.org/repo/pkgs/Xaw3d/Xaw3d-${version}.tar.gz/29ecfdcd6bcf47f62ecfd672d31269a1/Xaw3d-${version}.tar.gz
# If there are no patches, simply comment this
patch[0]=libXaw3d15E-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

topsrcdir=xc/lib/Xaw3d

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
#    generic_install DESTDIR
#    doc COPYING AUTHORS NEWS
    setdir ${srcdir}/${topsrcdir}/
    export PATH=$PATH:/usr/openwin/bin
    make BINDIR=${prefix}/bin INCROOT=${prefix}/include USRLIBDIR=${prefix}/lib SHLIBDIR=${prefix}/lib MANPATH=${prefix}/share/man DESTDIR=${stagedir} install
    chmod 755 ${stagedir}/${prefix}/lib/*.so*
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
