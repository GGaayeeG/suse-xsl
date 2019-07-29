#
# spec file for package suse-xsl-stylesheets-sbp
#
# Copyright (c) 2017 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#


Name:           suse-xsl-stylesheets-sbp
Version:        2.0.13
Release:        0

###############################################################
#
#  IMPORTANT:
#  Only edit this file directly in the Git repo:
#  https://github.com/openSUSE/daps, branch develop,
#  packaging/suse-xsl-stylesheets.spec
#
#  Your changes will be lost on the next update.
#  If you do not have access to the Git repository, notify
#  <fsundermeyer@opensuse.org> and <toms@opensuse.org>
#  or send a patch.
#
################################################################

%define susexsl_catalog   catalog-for-%{name}.xml
%define db_xml_dir        %{_datadir}/xml/docbook
%define suse_styles_dir   %{db_xml_dir}/stylesheet

Summary:        SUSE Best Practices Stylesheets for DocBook
License:        GPL-2.0 or GPL-3.0
Group:          Productivity/Publishing/XML
Url:            https://github.com/openSUSE/suse-xsl
Source0:        %{name}-%{version}.tar.bz2
Source1:        susexsl-fetch-source-git
Source2:        %{name}.rpmlintrc
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildArch:      noarch

BuildRequires:  docbook-xsl-stylesheets >= 1.77
BuildRequires:  docbook5-xsl-stylesheets >= 1.77
BuildRequires:  fdupes
BuildRequires:  libxml2-tools
BuildRequires:  libxslt
BuildRequires:  make
# Only needed to fix the "have choice" error between xerces-j2 and crimson
%if 0%{?suse_version} == 1210
BuildRequires:  xerces-j2
%endif
BuildRequires:  fontpackages-devel
BuildRequires:  trang

# docbook_4/docbook_5 are required to be able to transform DocBook documents
# that use predefined DocBook entities.
Requires:       docbook_4
Requires:       docbook_5
Requires:       docbook-xsl-stylesheets >= 1.77
Requires:       docbook5-xsl-stylesheets >= 1.77
Requires:       libxslt
Requires:       sgml-skel >= 0.7
Requires(post): sgml-skel >= 0.7
Requires(postun): sgml-skel >= 0.7


#------
# Fonts
#------

# Western fallback: currently necessary for building with XEP, it seems.
Requires:       ghostscript-fonts-std
# Western fallback 2: These should make the Ghostscript fonts unnecessary.
Requires:       gnu-free-fonts
# "Generic" font for use in cases where we don't want one of the gnu-free-fonts
Requires:       dejavu-fonts

# FONTS USED IN "suse" (aka "suse2005") STYLESHEETS
# Proprietary Western:
Recommends:     agfa-fonts
# Fallback for proprietary Western:
Requires:       liberation-fonts

# Japanese:
Requires:       sazanami-fonts
# Korean:
Requires:       un-fonts
# Chinese:
Requires:       wqy-microhei-fonts

# FONTS USED IN "suse2013" STYLESHEETS
# Western fonts:
Requires:       google-opensans-fonts
Requires:       sil-charis-fonts
# Monospace -- dejavu-fonts, already required
# Western fonts fallback -- gnu-free-fonts, already required
# Chinese simplified -- wqy-microhei-fonts, already required
# Chinese traditional:
Requires:       arphic-uming-fonts
# Japanese:
Requires:       ipa-pgothic-fonts
Requires:       ipa-pmincho-fonts
# Korean -- un-fonts, already required
# Arabic:
Requires:       arabic-amiri-fonts


%description
These are SUSE Best Practices XSLT 1.0 stylesheets for DocBook 4 and 5 that are be used
to create the HTML, PDF, and EPUB versions of SUSE documentation. These
stylesheets are based on the original DocBook XSLT 1.0 stylesheets.

#--------------------------------------------------------------------------

%prep
%setup -q -n %{name}

#--------------------------------------------------------------------------

%build
%__make  %{?_smp_mflags}

#--------------------------------------------------------------------------

%install
make install DESTDIR=%{buildroot} LIBDIR=%{_libdir}

# create symlinks:
%fdupes -s %{buildroot}/%{_datadir}

#----------------------
%post
# XML Catalogs
#
# remove old existing entries first - needed for
# zypper in, since it does not call postun
# delete ...

if [ "2" = "$1" ]; then
  edit-xml-catalog --group --catalog %{_sysconfdir}/xml/suse-catalog.xml \
    --del %{name} || true
fi

# ... and (re)add new catalogs
update-xml-catalog

%reconfigure_fonts_post
exit 0


%postun
update-xml-catalog

if [ "0" = "$1" ]; then
  %reconfigure_fonts_post

  edit-xml-catalog --group --catalog %{_sysconfdir}/xml/suse-catalog.xml \
    --del %{name} || true
fi

exit 0


#----------------------

%posttrans
%reconfigure_fonts_posttrans

#----------------------

%files
%defattr(-,root,root)

# Directories
%dir %{suse_styles_dir}
%dir %{suse_styles_dir}/suse2013-sbp
%dir %{suse_styles_dir}/suse2013-sbp-ns

%dir %{_defaultdocdir}/%{name}

# stylesheets
%{suse_styles_dir}/suse2013-sbp/*
%{suse_styles_dir}/suse2013-sbp-ns/*

# Catalogs
%config %{_sysconfdir}/xml/catalog.d/%{name}.xml

# Documentation
%doc %{_defaultdocdir}/%{name}/*

#----------------------

%changelog
