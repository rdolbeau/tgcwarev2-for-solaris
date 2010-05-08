#!/bin/bash
# This is a buildpkg build.sh script
# Copyright (C) 2003-2008 Tom G. Christensen <tgc@jupiterrise.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Written by Tom G. Christensen <tgc@jupiterrise.com>.

# build.sh helper functions
. ${BUILDPKG_BASE}/scripts/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=Error
version=0.17015
pkgver=1
source[0]=http://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/$topdir-$version.tar.gz
# If there are no patches, simply comment this
#patch[0]=

# Source function library
. ${BUILDPKG_BASE}/scripts/buildpkg.functions

# Global settings
maketest=1
perlpkgname="$(echo $pkgdir | ${__tr} '-' '_')"
__configure="perl"
configure_args="Makefile.PL"

reg prep
prep()
{
    generic_prep
}

reg build
build()
{
    generic_build_perl
}

reg check
check()
{
    generic_check
}

reg install
install()
{
    generic_install_perl
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