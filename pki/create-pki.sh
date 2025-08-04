SERVER_DNS_NAME="$1"

if [[ -z "$SERVER_DNS_NAME" ]]; then
  echo "Usage: $0 SERVER_DNS_NAME"
  exit 1
fi

X509_EXTENSION_CONFIG="authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $SERVER_DNS_NAME
"

echo "$X509_EXTENSION_CONFIG" > server.ext

set -eux

openssl genrsa -out ca.key
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt -subj '/CN=GCP OpenVPN Root CA/'
openssl genrsa -out server.key
openssl req -new -key server.key -out server.csr -subj '/CN=GCP OpenVPN Server/'
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
  -out server.crt -days 3650 -sha256 -extfile server.ext
openssl dhparam -out dh2048.pem 2048
