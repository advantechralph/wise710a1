#!/bin/bash

user=${1:-test}
pwd=${2:-123}
salt=${3:-salt}

#adduser --disabled-password --gecos "" $user
pwd_sha512=$(passwd -6 -salt $salt $pwd)
useradd -c '' -p "$pwd_sha512" -s /bin/bash -m $user

