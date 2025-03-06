{#
SPDX-FileCopyrightText: 2025 Blacky <blacky@blackies.de>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] == 'dom0' -%}

"{{ slsdotpath }}-dom0-icons-signal16":
  file.managed:
    - name: /usr/share/icons/hicolor/16x16/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop16.png
    - mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-dom0-icons-signal24":
  file.managed:
    - name: /usr/share/icons/hicolor/24x24/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop24.png
    - mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-dom0-icons-signal32":
  file.managed:
    - name: /usr/share/icons/hicolor/32x32/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop32.png
    - mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-dom0-icons-signal64":
  file.managed:
    - name: /usr/share/icons/hicolor/64x64/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop64.png
    - mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-dom0-icons-signal128":
  file.managed:
    - name: /usr/share/icons/hicolor/128x128/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop128.png
    - mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-dom0-icons-signal256":
  file.managed:
    - name: /usr/share/icons/hicolor/256x256/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop256.png
    - mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-dom0-icons-signal512":
  file.managed:
    - name: /usr/share/icons/hicolor/512x512/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop512.png
    - mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-dom0-icons-signal1024":
  file.managed:
    - name: /usr/share/icons/hicolor/1024x1024/apps/signal-desktop.png
    - source: salt://{{ slsdotpath }}/files/icons/signal-desktop1024.png
    - mode: '0644'
    - user: root
    - group: root
    - makedirs: True

"{{ slsdotpath }}-dom0-desktop-signal":
  file.managed:
    - name: /home/meister/Signal.desktop
    - source: salt://{{ slsdotpath }}/files/Signal.desktop
    - mode: '0750'
    - user: meister
    - group: meister
    - makedirs: True

{% endif -%}
