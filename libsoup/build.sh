#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=libsoup
baseversion=2.53
version=${baseversion}.1
pkgver=1
source[0]=http://ftp.gnome.org/pub/gnome/sources/${topdir}/${baseversion}/$topdir-$version.tar.xz
# If there are no patches, simply comment this
patch[0]=libsoup2531-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

#hack support for IPV6 for 7
case "${build_arch}-${gnu_os_ver}" in
    sparc-2.7)
	patch[1]=libsoup2531-002
	patch[2]=libsoup2531-003
        ;;
    *)
        ;;
esac


configure_args+=(--with-libiconv=gnu --enable-introspection=no --enable-vala=no)

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
