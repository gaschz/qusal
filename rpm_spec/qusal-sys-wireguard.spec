# SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

%define project         sys-wireguard
%define license_csv     AGPL-3.0-or-later,GPL-3.0-or-later
## Reproducibility.
%define source_date_epoch_from_changelog 1
%define use_source_date_epoch_as_buildtime 1
%define clamp_mtime_to_source_date_epoch 1
## Changelog is trimmed according to current date, not last date from changelog.
%define _changelog_trimtime 0
%define _changelog_trimage 0
%global _buildhost %{name}
## Python bytecode interferes when updates occur and restart is not done.
%undefine __brp_python_bytecompile

Name:           qusal-sys-wireguard
Version:        0.0.1
Release:        1%{?dist}
Summary:        Wireguard VPN in Qubes OS
Group:          qusal
Packager:       %{?_packager}%{!?_packager:Ben Grande <ben.grande.b@gmail.com>}
Vendor:         Ben Grande
License:        AGPL-3.0-or-later AND GPL-3.0-or-later
URL:            https://github.com/ben-grande/qusal
BugURL:         https://github.com/ben-grande/qusal/issues
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

Requires:       qubes-mgmt-salt
Requires:       qubes-mgmt-salt-dom0
Requires:       qusal-dev
Requires:       qusal-sys-net
Requires:       qusal-utils


%description
Setup a Wireguard VPN qube named "sys-wireguard" to provide network access to
other qubes through the VPN with fail closed mechanism.

%prep
%setup -q

%build

%check

%pre

%install
rm -rf -- %{buildroot}
install -m 755 -d -- \
  %{buildroot}/srv/salt/qusal \
  %{buildroot}%{_docdir}/%{name} \
  %{buildroot}%{_defaultlicensedir}/%{name}

for license in $(printf '%s\n' "%{license_csv}" | tr "," " "); do
  license_dir="LICENSES"
  if test -d "salt/%{project}/LICENSES"; then
    license_dir="salt/%{project}/LICENSES"
  fi
  install -m 644 -- \
    "${license_dir}/${license}.txt" %{buildroot}%{_defaultlicensedir}/%{name}/
done

install -m 644 -- salt/%{project}/README.md %{buildroot}%{_docdir}/%{name}/
rm -rf -- \
  salt/%{project}/LICENSES \
  salt/%{project}/README.md \
  salt/%{project}/.*
cp -rv -- salt/%{project} %{buildroot}/srv/salt/qusal/%{name}

%post
if test "$1" = "1"; then
  ## Install
  qubesctl state.apply sys-wireguard.create
  qubesctl --skip-dom0 --targets=tpl-sys-wireguard state.apply sys-wireguard.install
  qubesctl --skip-dom0 --targets=sys-wireguard state.apply sys-wireguard.configure
elif test "$1" = "2"; then
  ## Upgrade
  true
fi

%preun
if test "$1" = "0"; then
  ## Uninstall
  true
elif test "$1" = "1"; then
  ## Upgrade
  true
fi

%postun
if test "$1" = "0"; then
  ## Uninstall
  true
elif test "$1" = "1"; then
  ## Upgrade
  true
fi

%files
%defattr(-,root,root,-)
%license %{_defaultlicensedir}/%{name}/*
%doc %{_docdir}/%{name}/README.md
%dir /srv/salt/qusal/%{name}
/srv/salt/qusal/%{name}/*
%dnl TODO: missing '%ghost', files generated during %post, such as Qrexec policies.

%changelog
* Wed Jan 08 2025 Ben Grande <ben.grande.b@gmail.com> - c19997a
- fix: stricter command-line parsing

* Fri Aug 16 2024 Ben Grande <ben.grande.b@gmail.com> - 56a4296
- fix: skip YUM weak dependencies installation

* Tue Aug 06 2024 Ben Grande <ben.grande.b@gmail.com> - bdd4c78
- fix: avoid echo usage

* Tue Aug 06 2024 Ben Grande <ben.grande.b@gmail.com> - 1b2f1ba
- fix: avoid operand evaluation as argument

* Wed Jul 10 2024 Ben Grande <ben.grande.b@gmail.com> - 224312e
- feat: enable all optional shellcheck validations

* Tue Jul 09 2024 Ben Grande <ben.grande.b@gmail.com> - 011a71a
- style: limit line length per file extension

* Fri Jul 05 2024 Ben Grande <ben.grande.b@gmail.com> - 80482bf
- fix: use systemd-resolved DNS on boot

* Thu Jul 04 2024 Ben Grande <ben.grande.b@gmail.com> - 383c840
- doc: lint markdown files

* Fri Jun 28 2024 Ben Grande <ben.grande.b@gmail.com> - 59fc487
- fix: bind wireguard configuration directory

* Fri Jun 21 2024 Ben Grande <ben.grande.b@gmail.com> - c84dfea
- fix: generate RPM Specs for Qubes Builder V2

* Wed Jun 19 2024 Ben Grande <ben.grande.b@gmail.com> - 6ec0768
- fix: clean Wireguard rules

* Thu Jun 13 2024 Ben Grande <ben.grande.b@gmail.com> - a564b3a
- feat: add TCP proxy for remote hosts

* Tue May 28 2024 Ben Grande <ben.grande.b@gmail.com> - 44ea4c5
- feat: add manual page reader

* Mon Mar 18 2024 Ben Grande <ben.grande.b@gmail.com> - f9ead06
- fix: remove extraneous package repository updates

* Fri Feb 23 2024 Ben Grande <ben.grande.b@gmail.com> - 5605ec7
- doc: prefix qubesctl with sudo

* Mon Jan 29 2024 Ben Grande <ben.grande.b@gmail.com> - 6efcc1d
- chore: copyright update

* Sat Jan 20 2024 Ben Grande <ben.grande.b@gmail.com> - 422b01e
- feat: remove audiovm setting when unnecessary

* Mon Jan 08 2024 Ben Grande <ben.grande.b@gmail.com> - c306047
- fix: sys-wireguard compatible with Qubes 4.2

* Fri Jan 05 2024 Ben Grande <ben.grande.b@gmail.com> - 417843b
- feat: remove extraneous passwordless root

* Wed Dec 20 2023 Ben Grande <ben.grande.b@gmail.com> - 38d98ec
- fix: nft shebang and table names

* Tue Dec 19 2023 Ben Grande <ben.grande.b@gmail.com> - b4d142b
- refactor: move appended states to drop-in rc.local

* Mon Nov 13 2023 Ben Grande <ben.grande.b@gmail.com> - 963e72c
- chore: Fix unman copyright contact

* Mon Nov 13 2023 Ben Grande <ben.grande.b@gmail.com> - 5eebd78
- refactor: initial commit
