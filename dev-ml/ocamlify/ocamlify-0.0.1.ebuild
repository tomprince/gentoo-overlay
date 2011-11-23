# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit findlib multilib eutils

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://forge.ocamlcore.org/frs/download.php/379/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?] "
DEPEND="${RDEPEND}"

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	chmod +x configure
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_install() {
	findlib_src_install

	dodoc README.txt || die "doc install failed"
}
