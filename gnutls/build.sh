#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=gnutls
version=3.3.0
pkgver=2
source[0]=ftp://ftp.gnutls.org/gcrypt/gnutls/v3.3/${topdir}-${version}.tar.xz
# If there are no patches, simply comment this

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

case "${build_arch}-${gnu_os_ver}" in
    sparc-2.7)
        #/dev/random
        patch[0]=gnutls330-001
        ;;
    sparc-2.8)
	#missing IPV6_V6ONLY
	patch[0]=gnutls330-002
	#error with gets vs. std::gets
	patch[1]=gnutls330-003
	;;
    *)
        ;;
esac

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib -lrt"

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
