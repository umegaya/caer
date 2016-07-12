#!/bin/bash

cd /root/ca

# cleanup files
find . -name *.pem -exec rm -f {} \;
rm index.txt* serial* intermediate/index.txt* intermediate/serial intermediate/crlnumber
touch index.txt
touch intermediate/index.txt
echo 1000 > serial
echo 1000 > intermediate/serial
echo 1000 > intermediate/crlnumber

# create root key
openssl genrsa -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem

# create root cert
openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem

# create intermediate key
openssl genrsa -out intermediate/private/intermediate.key.pem 4096
chmod 400 intermediate/private/intermediate.key.pem

# create intermediate cert
openssl req -config intermediate/openssl.cnf -new -sha256 \
      -key intermediate/private/intermediate.key.pem \
      -out intermediate/csr/intermediate.csr.pem

# sign to cert
openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in intermediate/csr/intermediate.csr.pem \
      -out intermediate/certs/intermediate.cert.pem

# create cert chain
cat intermediate/certs/intermediate.cert.pem \
      certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem

chmod 444 intermediate/certs/ca-chain.cert.pem
