#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=pixman
version=0.32.8
pkgver=1
source[0]=http://cairographics.org/releases/${topdir}-${version}.tar.gz
# If there are no patches, simply comment this

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

#hack support for IPV6 for 7
case "${build_arch}-${gnu_os_ver}" in
    sparc-2.7)
	#remove MMAP test (we have mmap, but not MAP_ANON)
        patch[0]=pixman0328-001
	#libm doesn't have powf, only pow
        patch[1]=pixman0328-002
        ;;
    sparc-2.8)
	#libm doesn't have powf, only pow
        patch[0]=pixman0328-002
	patch[1]=pixman0328-003
	;;
    *)
        ;;
esac

configure_args+=(--with-libiconv=gnu --disable-tls)

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
