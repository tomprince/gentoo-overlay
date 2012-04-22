# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib git-2

DESCRIPTION="scripts for urxvt"
HOMEPAGE="https://github.com/muennich/urxvt-perls"
EGIT_REPO_URI="https://github.com/muennich/urxvt-perls.git"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-terms/rxvt-unicode[perl]"
RDEPEND="${DEPEND}
	x11-misc/xclip"

src_compile () { :; }

src_install ()
{
	insinto /usr/$(get_libdir)/urxvt/perl
	doins url-select
	doins clipboard
	doins keyboard-select
	dodoc README.md
}
