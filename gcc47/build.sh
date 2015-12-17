#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=gcc
version=4.7.4
pkgver=1
source[0]=ftp://ftp.sunet.se/pub/gnu/gcc/releases/$topdir-$version/$topdir-$version.tar.bz2
# If there are no patches, simply comment this
# v7/8 libitm
patch[0]=gcc474-001

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

# Common settings for gcc
. ${BUILDPKG_BASE}/gcc/build.sh.gcc.common

echo "we are ${build_arch}-${gnu_os_ver}"
case "${build_arch}-${gnu_os_ver}" in
    sparc-2.7)
        patch[1]=gcc474-sol7-001
#	patch[2]=gcc474-sol7-002
	patch[2]=gcc474-sol7-003
	patch[3]=gcc474-sol7-004
	configure_args+=(--disable-symvers --disable-tls)
	export LDFLAGS="-L$prefix/lib -R$prefix/lib -lsparcatomic"
	export LDFLAGS_FOR_TARGET="-L$prefix/lib -R$prefix/lib -lsparcatomic"
        ;;
    sparc-2.8)
        ;;
    *)
        ;;
esac

# Global settings
java_libver=13

# This compiler is bootstrapped with gcc 4.6.x
export PATH=/usr/tgcware/gcc46/bin:$PATH

reg prep
prep()
{
    generic_prep
}

reg build
build()
{
    setup_tools
    ${__mkdir} -p ${srcdir}/$objdir
    generic_build ../$objdir
}

reg install
install()
{
    clean stage
    setdir ${srcdir}/${objdir}
    ${__make} DESTDIR=$stagedir install
    custom_install=1
    generic_install
    ${__find} ${stagedir} -name '*.la' -print | ${__xargs} ${__rm} -f

    # Remove libffi
    ${__find} ${stagedir} -type l -name 'libffi*' -print | ${__xargs} ${__rm} -f
    ${__find} ${stagedir} -type f -name 'libffi*' -print | ${__xargs} ${__rm} -f
    ${__find} ${stagedir} -type f -name 'ffi*.h' -print | ${__xargs} ${__rm} -f
    ${__find} ${stagedir} -type f -name 'ffi*.3' -print | ${__xargs} ${__rm} -f
    # man3 is now empty
    ${__rmdir} ${stagedir}${prefix}/man/man3

    # libquadmath is not available on sparc but documentation is installed
    [ "$arch" = "sparc" ] && ${__rm} -f ${stagedir}${prefix}/info/libquadmath.info

    # Rearrange libraries
    redo_libs

    # Turn all the hardlinks in bin into symlinks
    redo_bin

    # Place share/docs in the regular location
    prefix=$topinstalldir
    doc COPYING* MAINTAINERS NEWS
}

reg check
check()
{
    setdir source
    setdir ../$objdir
    if [ $multilib -eq 0 ]; then
	${__make} -k check
    else
	${__make} -k RUNTESTFLAGS="--target_board='unix{,$multilib_testopt}'" check
    fi
}

reg pack
pack()
{
    iprefix=${topdir}${abbrev_majorminor}
    generic_pack
}

reg distclean
distclean()
{
    META_CLEAN="$META_CLEAN compver.*"
    clean distclean
    ${__rm} -rf $srcdir/$objdir
}

###################################################
# No need to look below here
###################################################
build_sh $*
