{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - .install-repo
  - utils.tools.common.update
  - dotfiles.copy-x11
  - sys-audio.install-client

"{{ slsdotpath }}-installed":
  pkg.installed:
    - require:
      - sls: {{ slsdotpath }}.install-repo
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs:
      - qubes-core-agent-networking
      - ca-certificates
      - qubes-core-agent-thunar
      - thunar
      - signal-desktop
      - dunst
      - libayatana-appindicator3-1
      - luit

"{{ slsdotpath }}-desktop-application-signal179":
  file.managed:
    - name: /usr/share/applications/signal179.desktop
    - source: salt://{{ slsdotpath }}/files/signal179.desktop
    - mode: '0644'
    - user: root
    - group: root
    - makedirs: True

{% endif -%}
