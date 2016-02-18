#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=cmake
version=2.8.12.2
pkgver=1
source[0]=https://${topdir}.org/files/v2.8/${topdir}-${version}.tar.gz
# If there are no patches, simply comment this
#patch[0]=

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

#configure_args+=

PARA=`psrinfo | tail -1 | awk '{ print $1 }'`
PARA=$((PARA+1))

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
    setdir ${srcdir}/${topsrcdir}/$1
#cmake configure doesn't understand --infodir
    ./configure --prefix=${prefix} --mandir=${prefix}/share/man --parallel=$PARA
    no_configure=1
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
