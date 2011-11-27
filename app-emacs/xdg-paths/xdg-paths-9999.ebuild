# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-2.0_p20101103.ebuild,v 1.1 2010/11/21 11:13:48 ulm Exp $

EAPI=4

inherit elisp eutils git-2

DESCRIPTION="Determine xdg base directories"
HOMEPAGE="https://github.com/tomprince/xdg-paths-el"
EGIT_REPO_URI="https://github.com/tomprince/xdg-paths-el.git"

if [[ $PV != 9999* ]]; then
	export EGIT_COMMIT="v${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""


DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

SITEFILE="50${PN}-gentoo.el"

src_compile ()
{
	elisp_src_compile
	elisp-make-autoload-file
}
