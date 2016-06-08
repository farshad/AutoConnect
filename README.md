# AutoConnect

This script helps you to collect your ssh connections in one place so you don't need use any username or password for a connection.
rpm and deb packages are built and placed on pkg directory.
you have to install these packages locally by your package manager.

## Instalition

deb package:

```sh
$ sudo dpkg -i /path/to/autoconnect_1.0-1_amd64.deb
```
rpm package:

```sh
$ sudo rpm -ihv /path/to/autoconnect-1-1.el7.centos.noarch.rpm
```

## Usage

after installation you can add a new host with this command:

```sh
$ sudo autoconnect -m
```

use "autoconnect" command for connecting to host:

```sh
$ autoconnect [operation No] [host No] 
```

> ######operation No contains these numbers:
> - 1-     Mount
> - 11-    Mount All Hosts
> - 2-     UnMount
> - 22-    UnMount All Hosts
> - 3-     SSH


for example, this command mounts first host in /mnt/hostname directory:

```sh
$ autoconnect 1 1
```


