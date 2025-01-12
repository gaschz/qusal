{#
SPDX-FileCopyrightText: 2022 - 2023 unman <unman@thirdeyesecurity.org>
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 - 2025 Blacky <gaschz@blackies.de>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' %}

"{{ slsdotpath }}-qvm-pass":
  file.managed:
    - name: /usr/bin/qvm-pass
    - source: salt://{{ slsdotpath }}/files/client/bin/qvm-pass
    - mode: '0755'
    - user: root
    - group: root
    - makedirs: True

"{{ slsdotpath }}-qubes-pass":
  file.directory:
    - name: /usr/libexec/qubes-pass
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True

"{{ slsdotpath }}-qubes-pass-symlink":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}-qubes-pass"
    - name: /usr/libexec/qubes-pass/pass
    - target: /usr/bin/qvm-pass
    - force: True

"{{ slsdotpath }}-default-pass-vm":
  file.append:
    - name: /rw/config/pass-split-domain
    - text: {{ slsdotpath }}

{#"{{ slsdotpath }}-path-pass":
  file.replace:
    - name: /home/user/.profile
    - pattern: '^(PATH=)(.*)games(.*)$'
    - repl: '\1"/usr/libexec/qubes-pass:${PATH}"'
    - onlyif: test -L /usr/libexec/qubes-pass/pass#}

"{{ slsdotpath }}-path-pass":
  file.append:
    - name: /home/user/.bashrc
    - text: 'PATH="/usr/libexec/qubes-pass:${PATH}"'

"{{ slsdotpath }}-passff-py":
  file.managed:
    - name: /home/user/.mozilla/native-messaging-hosts/passff.py
    - source: salt://{{ slsdotpath }}/files/client/native-messaging-hosts/passff.py
    - mode: '0750'
    - user: user
    - group: user
    - makedirs: True

"{{ slsdotpath }}-passff-json":
  file.managed:
    - name: /home/user/.mozilla/native-messaging-hosts/passff.json
    - source: salt://{{ slsdotpath }}/files/client/native-messaging-hosts/passff.json
    - mode: '0640'
    - user: user
    - group: user
    - makedirs: True

"{{ slsdotpath }}-gpg-agent-conf":
  file.managed:
    - name: /home/user/.gnupg/gpg-agent.conf
    - text: pinentry-program /usr/bin/pinentry-gnome3
    - makedirs: True

{% endif -%}
