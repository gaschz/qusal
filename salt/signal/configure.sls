{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - dotfiles.copy-x11
  - utils.tools.xfce

"{{ slsdotpath }}-desktop-autostart":
  file.symlink:
    - name: /home/user/.config/autostart/signal.desktop
    - target: /usr/share/applications/signal.desktop
    - user: user
    - group: user
    - force: True
    - makedirs: True

"{{ slsdotpath }}-desktop-application-signal179":
  file.managed:
    - name: /usr/share/applications/signal179.desktop
    - source: salt://{{ slsdotpath }}/files/signal179.desktop
    - mode: '0644'
    - user: root
    - group: root
    - makedirs: True

{% endif -%}
