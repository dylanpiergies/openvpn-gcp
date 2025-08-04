CLIENT_CN="$1"

if [[ -z "$CLIENT_CN" ]]; then
  echo "Usage: $0 CLIENT_CN"
  exit 1
fi

openssl genrsa -out "$CLIENT_CN".key
openssl req -new -key "$CLIENT_CN".key -out "$CLIENT_CN".csr -subj "/CN=$CLIENT_CN/"
openssl x509 -req -in "$CLIENT_CN".csr -CA ca.crt -CAkey ca.key \
  -out "$CLIENT_CN".crt -days 3650 -sha256
