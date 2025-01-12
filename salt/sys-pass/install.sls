{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 - 2025 Blacky <gaschz@blackies.de>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - utils.tools.common.update
  - dev.home-cleanup

"{{ slsdotpath }}-installed":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs:
      - gnupg2
      - pass
      - pass-otp
      - pinentry-gnome3
      - qtpass
      - man-db

"{{ slsdotpath }}-pass-rpc":
  file.recurse:
    - name: /etc/qubes-rpc/
    - source: salt://{{ slsdotpath }}/files/server/rpc/
    - user: root
    - group: root
    - file_mode: '0755'
    - makedirs: True

"{{ slsdotpath }}-desktop-application-qtpass":
  file.managed:
    - name: /usr/share/applications/qtpass.desktop
    - source: salt://{{ slsdotpath }}/files/server/qtpass.desktop
    - mode: '0644'
    - user: root
    - group: root
    - makedirs: True

{% endif -%}
