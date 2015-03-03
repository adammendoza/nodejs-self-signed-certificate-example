#!/bin/bash

bash make-root-ca-and-certificates.sh 'local.example.com'
echo ""

echo ""
node ./serve.js 8043 &
NODE_PID=$!
sleep 1

echo ""
echo ""
node ./request-without-warnings.js 8043 'local.example.com'
echo -n " - without warnings, love node.js' https"
echo ""
sleep 1

echo ""
curl https://local.example.com:8043 \
  --cacert certs/client/my-root-ca.crt.pem
echo -n " - without warnings, love cURL"
echo ""
sleep 1

# For lots of output about the ssl connection try -v
#curl -v https://local.ldsconnect.org:8043 \
#  --cacert certs/client/my-root-ca.crt.pem

kill ${NODE_PID}
echo ""
