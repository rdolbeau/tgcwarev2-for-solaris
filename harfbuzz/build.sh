#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=harfbuzz
version=1.0.6
pkgver=1
source[0]=http://www.freedesktop.org/software/${topdir}/release/${topdir}-${version}.tar.bz2
# If there are no patches, simply comment this
#no scalbnf
patch[0]=harfbuzz106-001
#no lround
patch[1]=harfbuzz106-002
#disable mmap (no MAP_ANON)
patch[2]=harfbuzz106-003

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib -lsparcatomic"

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
