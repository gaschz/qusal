{#
SPDX-FileCopyrightText: 2024 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

include:
  - sys-gui.cancel-common

"{{ slsdotpath }}-disable-autostart":
  qvm.prefs:
    - name: {{ slsdotpath }}
    - autostart: False
