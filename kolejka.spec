# Don't try fancy stuff like debuginfo, which is useless on binary-only
# packages. Don't strip binary too
# Be sure buildpolicy set to do nothing
%define        __spec_install_post %{nil}
%define          debug_package %{nil}
%define        __os_install_post %{_dbpath}/brp-compress

Summary: Gets queue lengths from city council website and saves as csv
Name: kolejka 
Version: 1.0
Release: 2 
License: GPL+
Group: Development/Tools
SOURCE0 : %{name}-%{version}.tar.gz
URL: http://erth111.wordpress.com/

BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
%{summary}

%prep
%setup -q

%build
# Empty section.

%install
rm -rf %{buildroot}
mkdir -p  %{buildroot}

# in builddir
cp -a * %{buildroot}


%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%config(noreplace) %{_sharedstatedir}/%{name}/%{version}/conf/%{name}.conf
%{_sharedstatedir}/%{name}/%{version}/*

%changelog
* Thu Apr 24 2016 erth111 <erth111@gmail.com> 
- Second build 
