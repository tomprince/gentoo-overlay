# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-2.0_p20101103.ebuild,v 1.1 2010/11/21 11:13:48 ulm Exp $

EAPI=4

inherit elisp eutils git-2

DESCRIPTION="Extensible vi layer"
HOMEPAGE="http://gitorious.org/evil"
SRC_URI=""
EGIT_REPO_URI="git://gitorious.org/evil/evil.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""


DEPEND="app-emacs/undo-tree"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

BYTECOMPFLAGS="${BYTECOMPFLAGS} -L lib"

src_compile() {
	local EVILFILES=( *.el )
	EVILFILES=( ${EVILFILES[@]//evil-tests.el/} )
	EVILFILES=( ${EVILFILES[@]//evil-pkg.el/} )
	elog ${EVILFILES[@]}
	elisp-compile ${EVILFILES[@]} || die
	elisp-make-autoload-file || die
}

src_install() {
	local EVILFILES=( *.{el,elc} )
	EVILFILES=( ${EVILFILES[@]//evil-tests.el/} )
	EVILFILES=( ${EVILFILES[@]//evil-pkg.el/} )
	elisp-install ${PN} ${EVILFILES[@]} || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
