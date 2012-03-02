# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Salt is a powerful remote execution manager that can be used to
administer servers in a fast and efficient way."
HOMEPAGE="http://saltstack.org/"
SRC_URI="https://github.com/downloads/saltstack/salt/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/pyzmq
	dev-python/m2crypto
	dev-python/pycrypto
	dev-python/pyyaml
	dev-python/jinja2
	"
RDEPEND="${DEPEND}"
