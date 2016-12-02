#!/bin/sh

if [ -z $1 ]; then
	echo "usage: newca.sh NAME (OUTPUT DIR)"
	exit 1
fi
NAME=$1
OUT=${2:-out}
if [ -z $OUT ]; then
	echo "no output dir specified"
	exit 1
fi

cd /root/ca

# writable permissions
chmod 777 intermediate/index.*
chmod 777 intermediate/serial*

# create key
openssl genrsa -out $OUT/$NAME.key 2048

# create csr
openssl req -config intermediate/openssl.cnf \
      -key $OUT/$NAME.key \
      -new -sha256 -out $OUT/$NAME.csr

openssl ca -config intermediate/openssl.cnf \
      -extensions server_cert -days 3650 -notext -md sha256 \
      -in $OUT/$NAME.csr \
      -out $OUT/$NAME.crt

# verify
openssl x509 -noout -text -in $OUT/$NAME.crt

# copy results1	
cp intermediate/certs/ca-chain.cert.pem $OUT/$NAME.ca
	
