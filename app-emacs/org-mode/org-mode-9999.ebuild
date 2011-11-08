# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-7.7.ebuild,v 1.1 2011/08/04 07:33:33 ulm Exp $

EAPI=4
NEED_EMACS=22

EGIT_REPO_URI="git://orgmode.org/org-mode.git"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
else
	SRC_URI="http://orgmode.org/org-${PV}.tar.gz"
fi

inherit elisp ${GIT_ECLASS}

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"


LICENSE="GPL-3 FDL-1.3 contrib? ( GPL-2 MIT as-is )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-macos"
IUSE="contrib"

S="${WORKDIR}/org-${PV}"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# Remove autoload file to make sure that it is regenerated with
	# the right Emacs version.
	rm -f lisp/org-install.el
}

src_compile() {
	default
	if [[ ${PV} = 9999* ]]; then
		emake info pdf card
	fi
}

src_install() {
	emake \
		prefix="${ED}/usr" \
		lispdir="${ED}${SITELISP}/${PN}" \
		infodir="${ED}/usr/share/info" \
		install

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	doinfo doc/org
	dodoc README doc/org.pdf doc/orgcard.pdf doc/orgguide.pdf

	if use contrib; then
		elisp-install ${PN}/contrib contrib/lisp/*org*.el || die
		insinto /usr/share/doc/${PF}/contrib
		doins -r contrib/README contrib/babel contrib/odt contrib/scripts
		find "${ED}/usr/share/doc/${PF}/contrib" -type f -name '.*' \
			-exec rm -f '{}' '+'
	fi
}
