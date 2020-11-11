#!/bin/bash

apt-get update
apt-get install -y vsftpd

cp -a /etc/vsftpd.conf /etc/vsftpd.conf.bkp
cat << EOF >> /etc/vsftpd.conf

userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
write_enable=YES
chroot_local_user=YES
local_umask=022
user_sub_token=$USER
local_root=/home/$USER/ftp

EOF


cat << EOF > /etc/vsftpd.userlist
test
EOF

mkdir -p /home/test/ftp
chmod go-w /home/test/ftp
chown nobody:nogroup /home/test/ftp
mkdir -p /home/test/ftp/test
chown test:test /home/test/ftp/test

systemctl restart vsftpd

