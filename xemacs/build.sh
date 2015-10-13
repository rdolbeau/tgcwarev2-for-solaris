#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=xemacs
version=21.5.34
pkgver=1
source[0]=http://ftp.fr.xemacs.org/pub/xemacs/beta/${topdir}-${version}.tar.gz
# If there are no patches, simply comment this
# b2m use getopt_long
patch[0]=xemacs21534-001
# missing DESTDIR
patch[1]=xemacs21534-002

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

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
