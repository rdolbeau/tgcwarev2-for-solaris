#!/bin/bash
# This is a buildpkg build.sh script
# build.sh helper functions
. ${BUILDPKG_SCRIPTS}/build.sh.functions
#
###########################################################
# Check the following 4 variables before running the script
topdir=nethack
version=3.6.0
pkgver=1
source[0]=http://heanet.dl.sourceforge.net/project/${topdir}/${topdir}/${version}/${topdir}-360-src.tgz
# If there are no patches, simply comment this
patch[0]=nethack360-001-config
patch[1]=nethack360-002-wrapper

# Source function library
. ${BUILDPKG_SCRIPTS}/buildpkg.functions

export LFLAGS="-L$prefix/lib -R$prefix/lib"

gamesprefix=${prefix}/games
nethackdir=${gamesprefix}/lib/nethackdir

reg prep
prep()
{
    generic_prep
}

reg build
build()
{
     setdir ${srcdir}/${topsrcdir}/sys/unix
     sh setup.sh hints/unix
     setdir ${srcdir}/${topsrcdir}/
     make CC=gcc \
	PREFIX=${prefix} \
	INSTDIR=${stagedir}${nethackdir} \
	VARDIR=${stagedir}${nethackdir} \
	SHELLDIR=${stagedir}${gamesprefix} \
	VARDATND="x11tiles NetHack.ad pet_mark.xbm pilemark.xbm" \
	WINSRC='$(WINTTYSRC) $(WINX11SRC)' WINOBJ='$(WINTTYOBJ) $(WINX11OBJ)' WINLIB='$(WINTTYLIB) $(WINX11LIB)' WINX11LIB="-lXaw -lXmu -lXext -lXt -lXpm -lX11 -lm" \
	LEX="flex" YACC="bison -y" GAMEUID=`whoami` GAMEGRP=`groups| awk '{ print $1 }'` -j4

}

reg check
check()
{
    generic_check
}

reg install
install()
{
    setdir ${srcdir}/${topsrcdir}/
    make CC=gcc \
        PREFIX=${prefix} \
        INSTDIR=${stagedir}${nethackdir} \
        VARDIR=${stagedir}${nethackdir} \
        SHELLDIR=${stagedir}${gamesprefix} \
        VARDATND="x11tiles NetHack.ad pet_mark.xbm pilemark.xbm" \
        WINSRC='$(WINTTYSRC) $(WINX11SRC)' WINOBJ='$(WINTTYOBJ) $(WINX11OBJ)' WINLIB='$(WINTTYLIB)
 $(WINX11LIB)' WINX11LIB="-lXaw -lXmu -lXext -lXt -lXpm -lX11 -lm" \
        LEX="flex" YACC="bison -y" GAMEUID=`whoami` GAMEGRP=`groups| awk '{ print $1 }'` install
    touch ${stagedir}${prefix}/games/lib/nethackdir/sysconf 
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
