{#
SPDX-FileCopyrightText: 2022 - 2023 unman <unman@thirdeyesecurity.org>
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 - 2025 Blacky <gaschz@kisss.de>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' %}

include:
  - dev.home-cleanup
  - dotfiles.copy-sh
  - dotfiles.copy-pgp

"{{ slsdotpath }}-save-keys":
  file.recurse:
    - name: /home/user/.gnupg/download/
    - source: salt://{{ slsdotpath }}/files/server/keys/
    - user: user
    - group: user
    - file_mode: '0600'
    - dir_mode: '0700'
    - makedirs: True

"{{ slsdotpath }}-import-pubs":
  cmd.run:
    - require:
      - file: "{{ slsdotpath }}-save-keys"
    - name: gpg --status-fd=2 --homedir . --import download/*.pub
    - cwd: /home/user/.gnupg
    - runas: user
    - success_stderr: IMPORT_OK
{#  per Hand: Passwort! #}
"{{ slsdotpath }}-import-keys":
  cmd.run:
    - require:
      - file: "{{ slsdotpath }}-save-keys"
    - name: gpg --status-fd=2 --homedir . --import download/*.key
    - cwd: /home/user/.gnupg
    - runas: user
    - success_stderr: IMPORT_OK

"{{ slsdotpath }}-import-ownertrust":
  cmd.run:
    - require:
      - cmd: "{{ slsdotpath }}-import-pubs"
    - name: gpg --homedir . --import-ownertrust download/otrust.txt
    - cwd: /home/user/.gnupg
    - runas: user

"{{ slsdotpath }}-desktop-application-qtpass":
  file.managed:
    - name: /usr/share/applications/qtpass.desktop
    - source: salt://{{ slsdotpath }}/files/server/qtpass.desktop
    - mode: '0644'
    - user: root
    - group: root
    - makedirs: True

"{{ slsdotpath }}-data-extract-ui":
  archive.extracted:
    - name: '/home/user'
    - source: salt://{{ slsdotpath }}/files/server/241217_password.tar.gz
    - user: user
    - group: user

{% endif -%}
