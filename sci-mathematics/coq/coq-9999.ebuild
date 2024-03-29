# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.3_p2.ebuild,v 1.2 2011/10/05 18:54:43 aballier Exp $

EAPI="4"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
	EXPERIMENTAL="true"
fi

inherit eutils multilib ${GIT_ECLASS}

MY_PV=${PV/_p/pl}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
if [[ $PV != 9999* ]]; then
	SRC_URI="http://${PN}.inria.fr/V${MY_PV}/files/${MY_P}.tar.gz"
fi

EGIT_REPO_URI="git://scm.gforge.inria.fr/coq/coq-svn.git"
EGIT_BRANCH=trunk

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk debug +ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
	>=dev-ml/camlp5-5.09[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.10.1[ocamlopt?] )"
DEPEND="${RDEPEND}
	doc? (
		media-libs/netpbm[png,zlib]
		virtual/latex-base
		dev-tex/hevea
		dev-tex/xcolor
		dev-texlive/texlive-pictures
		dev-texlive/texlive-mathextra
		dev-texlive/texlive-latexextra
		)"

S=${WORKDIR}/${MY_P}

src_configure() {
	ocaml_lib=`ocamlc -where`
	local myconf="--prefix /usr
		--bindir /usr/bin
		--libdir /usr/$(get_libdir)/coq
		--mandir /usr/share/man
		--emacslib /usr/share/emacs/site-lisp
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc
		--docdir /usr/share/doc/${PF}
		--camlp5dir ${ocaml_lib}/camlp5
		--lablgtkdir ${ocaml_lib}/lablgtk2
		--configdir /etc/xdg/coq"

	use debug && myconf="--debug $myconf"
	use doc || myconf="$myconf --with-doc no"

	if use gtk; then
		use ocamlopt && myconf="$myconf --coqide opt"
		use ocamlopt || myconf="$myconf --coqide byte"
	else
		myconf="$myconf --coqide no"
	fi
	use ocamlopt || myconf="$myconf -byte-only"
	use ocamlopt && myconf="$myconf --opt"

	export CAML_LD_LIBRARY_PATH="${S}/kernel/byterun/"
	./configure $myconf || die "configure failed"
}

src_compile() {
	emake STRIP="true" -j1 || die "make failed"
}

src_install() {
	emake STRIP="true" COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	use gtk && domenu "${FILESDIR}/coqide.desktop"
}
