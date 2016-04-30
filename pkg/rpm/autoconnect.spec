Name:autoconnect		
Version:	1
Release:	1%{?dist}
Summary: Auto Connect To Server

Group:		Applications/Communications
License:	MIT
URL:		https://github.com/farshad/AutoConnect
Source0:	autoconnect-1.0.tar.gz

#BuildRequires:	
Requires: expect, sshfs

BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-buildroot

%description
Auto connect to server with ssh and sshfs via username and password.

%prep
%setup -q

%build
%install
rm -rf %{buildroot}
mkdir -p %{buildroot}

install -m 0775 -d $RPM_BUILD_ROOT/var/lib/autoconnect
install -m 0775 -d $RPM_BUILD_ROOT/usr/sbin
install -m 0755 lib/* $RPM_BUILD_ROOT/var/lib/autoconnect
install -m 0755 autoconnect $RPM_BUILD_ROOT/usr/sbin/autoconnect

%files
%dir /var/lib/autoconnect
/var/lib/autoconnect/*
/usr/sbin/autoconnect

%changelog

