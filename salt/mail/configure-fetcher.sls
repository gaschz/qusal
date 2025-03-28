{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' %}

include:
  - dotfiles.copy-x11
  - dotfiles.copy-sh

"{{ slsdotpath }}-fetcher-fdm.conf.example":
  file.managed:
    - name: /home/user/.fdm.conf.example
    - source: salt://{{ slsdotpath }}/files/fetcher/fdm.conf.example
    - mode: "0600"
    - user: user
    - group: user
    - makedirs: True

"{{ slsdotpath }}-fetcher-mpoprc.example":
  file.managed:
    - name: /home/user/.mpoprc.example
    - source: salt://{{ slsdotpath }}/files/fetcher/mpoprc.example
    - mode: "0600"
    - user: user
    - group: user
    - makedirs: True

"{{ slsdotpath }}-fetcher-offlineimaprc.example":
  file.managed:
    - name: /home/user/.offlineimaprc.example
    - source: salt://{{ slsdotpath }}/files/fetcher/offlineimaprc.example
    - mode: "0600"
    - user: user
    - group: user
    - makedirs: True

"{{ slsdotpath }}-fetcher-netrc.example":
  file.managed:
    - name: /home/user/.netrc.example
    - source: salt://{{ slsdotpath }}/files/fetcher/netrc.example
    - mode: "0600"
    - user: user
    - group: user
    - makedirs: True

{% endif -%}
