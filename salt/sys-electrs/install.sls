{#
SPDX-FileCopyrightText: 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

## ElectRS does not provide official binaries. This state exists to be the
## default installation.
include:
  - {{ slsdotpath }}.install-source

{% endif -%}
