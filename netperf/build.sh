#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=netperf
version=2.3
pkgver=1
source[0]=ftp://ftp.${topdir}.org/${topdir}/archive/${topdir}-${version}.tar.gz
# If there are no patches, simply comment this
#patch[0]=

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-lsocket -lnsl -lkstat -L$prefix/lib -R$prefix/lib"

reg prep
prep()
{
    generic_prep
}

reg build
build()
{
    setdir ${srcdir}/${topsrcdir}
    make CC=gcc NETPERF_HOME=${stagedir}/${prefix}/bin CFLAGS="-O -DDEBUG_LOG_FILE=\\\"/tmp/netperf.debug\\\" -DDO_UNIX" LIBS="-lm -lsocket -lnsl -lkstat" -j3
}

reg check
check()
{
    generic_check
}

reg install
install()
{
    setdir ${srcdir}/${topsrcdir}
    make CC=gcc NETPERF_HOME=${stagedir}/${prefix}/bin CFLAGS="-O -DDEBUG_LOG_FILE=\\\"/tmp/netperf.de
bug\\\" -DDO_UNIX" LIBS="-lm -lsocket -lnsl -lkstat" install
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
