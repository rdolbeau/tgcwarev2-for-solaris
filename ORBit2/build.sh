#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=ORBit2
version=2.14.19
pkgver=1
source[0]=ftp://ftp.gnome.org/pub/gnome/sources/${topdir}/2.14/${topdir}-${version}.tar.bz2
# If there are no patches, simply comment this
# obsolete stuff
patch[0]=ORBit221419-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

case "${build_arch}-${gnu_os_ver}" in
    sparc-2.7)
	# if_nameindex, need a better fix
	patch[1]=ORBit221419-002
        ;;
    *)
        ;;
esac

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
