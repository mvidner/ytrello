#
# spec file for package rubygem-ytrello
#
# Copyright (c) 2018 SUSE LINUX GmbH, Nuernberg, Germany.
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

Name:           rubygem-ytrello
Version:        0.19.0
Release:        0
%define mod_name ytrello
%define mod_full_name %{mod_name}-%{version}
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
Requires:       python-bugzilla >= 2.1.0
BuildRequires:  ruby-macros >= 5
BuildRequires:  %{ruby}
BuildRequires:  %{rubygem gem2rpm}
BuildRequires:  update-alternatives
Url:            https://github.com/mvidner/ytrello
Source:         https://rubygems.org/gems/%{mod_full_name}.gem
Summary:        Tools to help with the YaST Trello boards and Bugzilla
License:        MIT
Group:          Development/Languages/Ruby
PreReq:         update-alternatives

%description
Ytrello are tools to help my Scrum team manage Trello cards and Bugzilla bugs.
Much of the configuration is harcoded now, yuck!.

%prep

%build

%install
%gem_install \
  --symlink-binaries \
  --doc-files="README.md" \
  -f

%gem_packages

%changelog
