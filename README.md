# caer
certificate authorizer
heavily based on https://jamielinux.com/docs/openssl-certificate-authority/

# usage
```
git clone https://github.com/umegaya/caer
make ca # create your CA
# add your information for CA
make cert NAME=foo
# add your information for cert
# foo.certs contains foo.crt, foo.key, foo.ca as certificate, signing key, intermediate certificate
```
