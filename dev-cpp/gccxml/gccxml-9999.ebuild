# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gccxml/gccxml-0.9.0_pre20090516-r1.ebuild,v 1.1 2009/11/16 15:17:46 scarabeus Exp $

EAPI="2"

inherit cmake-utils cvs

DESCRIPTION="XML output extension to GCC"
HOMEPAGE="http://www.gccxml.org/"
ECVS_SERVER=www.gccxml.org:/cvsroot/GCC_XML
ECVS_USER=anoncvs
ECVS_MODULE=gccxml

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${ECVS_MODULE}"
