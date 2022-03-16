#!/usr/bin/env bash

# Fail on unset variables and command errors
set -ue -o pipefail

# Prevent commands misbehaving due to locale differences
export LC_ALL=C

FILE_NAME=selfsigned
OUTPUT_DIR=`dirname $0`/tmp
DOMAIN=localhost

mkdir -p $OUTPUT_DIR
rm -f ${OUTPUT_DIR}/*

tmpfile=$(mktemp -t prefix.XXXXXXXX)
echo $tmpfile
# see https://stackoverflow.com/questions/43665243/chrome-invalid-self-signed-ssl-cert-subject-alternative-name-missing
cat << EOF > $tmpfile
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = ${DOMAIN}
EOF

echo genrsa
openssl genrsa 2048 \
  > ${OUTPUT_DIR}/${FILE_NAME}.key
echo req
openssl req -new -subj "/CN=${DOMAIN}" \
  -key ${OUTPUT_DIR}/${FILE_NAME}.key \
  > ${OUTPUT_DIR}/${FILE_NAME}.csr
echo x509
openssl x509 -days 3650 -req -sha256 \
  -extfile ${tmpfile} \
  -signkey ${OUTPUT_DIR}/${FILE_NAME}.key \
  < ${OUTPUT_DIR}/${FILE_NAME}.csr \
  > ${OUTPUT_DIR}/${FILE_NAME}.crt
rm -f $tmpfile

cp ${OUTPUT_DIR}/* nginx/certs/
cp ${OUTPUT_DIR}/* frontend/certs/
