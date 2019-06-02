#!/bin/bash

# Check required environment variables are set
if [[ -z "${DOMAIN}" ]]
then
    echo "DOMAIN not found" 
    exit 1
fi

if [[ -z "${!NODE_NAME@}" ]]
then
    echo "NODE_NAME not found"
    exit 1
fi

# Generate CA certificate
echo "Generating CA certificate..."

echo '{"CN":"CA","key":{"algo":"rsa","size":2048}}' | cfssl gencert -initca - | cfssljson -bare ca -
echo '{"signing":{"default":{"expiry":"43800h","usages":["signing","key encipherment","server auth","client auth"]}}}' > ca-config.json

# Generate certificates for each node
for var in "${!NODE_NAME@}"; do

    name="${!var}"
    domain="${DOMAIN}"
    address="$name.$domain"

    echo "Generating certificate for $address"
    
    echo '{"CN":"'$name'","hosts":[""],"key":{"algo":"rsa","size":2048}}' | cfssl gencert -config=ca-config.json -ca=ca.pem -ca-key=ca-key.pem -hostname="$address" - | cfssljson -bare $name

    echo "The following files were generated at ${PWD}"
    ls -lst

done
