#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=gcc
version=4.5.4
pkgver=3
source[0]=ftp://ftp.sunet.se/pub/gnu/gcc/releases/$topdir-$version/$topdir-$version.tar.bz2
# If there are no patches, simply comment this
patch[0]=gcc-4.5.4-pr45915.patch

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

# Common settings for gcc
. ${BUILDPKG_BASE}/gcc/build.sh.gcc.common

# Global settings
java_libver=11

# This compiler is bootstrapped with gcc 4.4.7
export PATH=/usr/tgcware/gcc44/bin:$PATH

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
    ${__find} ${stagedir} -type d -name 'libffi' -print | ${__xargs} ${__rmdir}
    ${__find} ${stagedir} -type f -name 'ffi*.3' -print | ${__xargs} ${__rm} -f
    # man3 is now empty
    ${__rmdir} ${stagedir}${prefix}/man/man3

    # Rearrange libraries
    redo_libs

    # Turn all the hardlinks in bin into symlinks
    redo_bin

    # Java python bits are in the wrong place
    ${__mkdir} -p ${stagedir}${lprefix}/share/gcc-${version}/python/libjava
    ${__mv} ${stagedir}${lprefix}/share/python/{aotcompile,classfile}.py ${stagedir}${lprefix}/share/gcc-${version}/python/libjava
    ${__rmdir} ${stagedir}${lprefix}/share/python

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
