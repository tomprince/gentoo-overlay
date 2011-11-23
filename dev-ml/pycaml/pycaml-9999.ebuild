# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit findlib python eutils git

IUSE="+ocamlopt"

DESCRIPTION="Bindings for Python and OCaml"
HOMEPAGE="http://github.com/tomprince/pycaml"
SRC_URI=""
EGIT_REPO_URI="git://github.com/tomprince/pycaml.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

RDEPEND=">=dev-lang/ocaml-3.11.1
        >=dev-lang/python-2.7.0:2.7"
DEPEND="dev-ml/oasis
        ${RDEPEND}"

S="${WORKDIR}/${PN}"

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	oasis setup
	chmod +x configure
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_install() {
	findlib_src_install
}
