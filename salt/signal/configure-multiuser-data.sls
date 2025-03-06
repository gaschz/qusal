{#
SPDX-FileCopyrightText: 2024 Blacky <blacky@blackies.de>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - .install-multiuser

"{{ slsdotpath }}-data-dir":
  file.directory:
    - names:
      - '/home/signal'
      - '/home/user/QubesIncoming'
    - dir_mode: "0770"
    - user: user
    - group: user
    - makedirs: true

"{{ slsdotpath }}-link-user":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}-data-dir"
    - names:
      - "/home/signal179/Download"
      - "/home/signal157/Download"
      - "/home/signalui/Download"
      - "/home/user/Download"
      - "/home/user/QubesIncoming/work"
      - "/home/user/QubesIncoming/personal"
    - target: "/home/signal"
    - mode: "0770"
    - force: true
    - user: root
    - group: root

"{{ slsdotpath }}-data-extract-ui":
  archive.extracted:
    - name: '/'
    - source: salt://{{ slsdotpath }}/files/signal_daten.tar.gz
    - group: user

{% endif -%}
