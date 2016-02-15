#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=icu4c
version=55.1
pkgver=1
#source[0]=http://download.icu-project.org/files/icu4c/56.1/icu4c-56_1-src.tgz
source[0]=http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-src.tgz
# If there are no patches, simply comment this
#-std=gnu99 allows to compile wchar.h
patch[0]=icu4c551-001
#UINTPTR_MAX is defined but empty in Sol7 & Sol8
patch[1]=icu4c551-002

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export CPPFLAGS="-I$prefix/include"
export LDFLAGS="-L$prefix/lib -R$prefix/lib -lsparcatomic"

topsrcdir=icu/source

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
