{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- from "qvm/template.jinja" import load -%}

{%- import slsdotpath ~ "/template.jinja" as template -%}

include:
  - fedora-xfce.create
  - fedora-xfce.prefs
  - {{ slsdotpath }}.clone

"dvm-{{ template.template }}-absent":
  qvm.absent:
    - names:
      - {{ template.template_clean }}-dvm
      - {{ template.template }}-dvm

{% load_yaml as defaults -%}
name: {{ template.template }}
force: True
require:
- sls: {{ template.template_clean }}.clone
- sls: fedora-xfce.create
present:
- label: black
prefs:
- label: black
- audiovm: ""
- vcpus: 1
- memory: 300
- maxmem: 600
- include_in_backups: False
- management_dispvm: dvm-fedora-xfce
features:
- set:
  - menu-items: "qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
  - default-menu-items: "qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% load_yaml as defaults -%}
name: dvm-{{ template.template_clean }}
force: True
require:
- sls: {{ template.template_clean }}.clone
present:
- template: {{ template.template }}
- label: red
prefs:
- template: {{ template.template }}
- label: red
- audiovm: ""
- vcpus: 1
- memory: 300
- maxmem: 400
- template_for_dispvms: True
- include_in_backups: False
features:
- enable:
  - appmenus-dispvm
- set:
  - menu-items: "qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}
