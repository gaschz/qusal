#!/bin/bash
# Blacky 2025
#

cd /srv/salt
mv qusal qusal.old || mkdir -m 770 qusal
qvm-run -u root --pass-io sys-git 'cd /home/user/mirror/qusal/salt && tar cf - ./*' | tar -x -C qusal

cd /srv/salt/qusal
qvm-run -u root --pass-io sys-git 'cd /home/user/mirror/dotfiles && tar cf - ./*' | tar -x -C dotfiles

cd /srv/salt/qusal/sys-pass
qvm-run -u root --pass-io sys-git 'cd /home/user/mirror/qubes-pass && tar cf - ./*' | tar -x -C qubes-pass
qvm-run -u root --pass-io sys-git 'cd /home/user/mirror/passff-host && tar cf - ./*' | tar -x -C passff-host

cd /srv/salt
chown -R root:root qusal
chmod -R o-rwx qusal

exit 0
