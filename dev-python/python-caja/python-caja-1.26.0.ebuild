# Distributed under the terms of the GNU General Public License v2

EAPI=7

MATE_LA_PUNT="yes"
PYTHON_COMPAT=( python3+ )

inherit mate python-single-r1

DESCRIPTION="Python bindings for the Caja file manager"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"

IUSE="doc"
REQUIRED_USE=${PYTHON_REQUIRED_USE}

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.50:2
	$( python_gen_cond_dep 'dev-python/pygobject:3[${PYTHON_USEDEP}]' )
	>=mate-base/caja-1.17.1[introspection]
	>=x11-libs/gtk+-3.22:3
"

RDEPEND="${COMMON_DEPEND}"

BDEPEND="${COMMON_DEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	doc? ( app-text/docbook-xml-dtd:4.1.2 )
"

src_prepare() {
	MATE_FORCE_AUTORECONF="true"

	sed -i "s/\$(PACKAGE)/${PF}/g" examples/Makefile.am || die
	mate_src_prepare
}

src_install() {
	mate_src_install

	# Keep the directory for systemwide extensions.
	keepdir /usr/share/caja-python/extensions/

	# The HTML documentation generation is broken and commented out by upstream.
	#
	#if use doc ; then
	#	insinto /usr/share/gtk-doc/html/nautilus-python # for dev-util/devhelp
	#	doins -r docs/html/*
	#fi
}
