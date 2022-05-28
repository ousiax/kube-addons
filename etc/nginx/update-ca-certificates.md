```console
$ sudo mkdir /usr/local/share/ca-certificates/local.io
$ sudo cp local.io.crt /usr/local/share/ca-certificates/local.io
$ sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...

Adding debian:local.io.pem
done.
done.
```
