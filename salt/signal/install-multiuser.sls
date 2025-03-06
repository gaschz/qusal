{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

#include:
#  - .install
#
#"{{ slsdotpath }}-signal-installed":
#  pkg.installed:
#    - require:
#      - pkg: "{{ slsdotpath }}.install"
#    - install_recommends: False
#    - skip_suggestions: True
#    - setopt: "install_weak_deps=False"
#    - pkgs:
#      - signal-desktop

"{{ slsdotpath }}-user-add":
  user.present:
    - names:
      - signal179
      - signal157
      - signalui
    - gid: user

{% endif -%}
