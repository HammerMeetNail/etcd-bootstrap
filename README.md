# etcd-bootstrap
A repo for creating a secure etcd cluster

# Table of Contents

- [Overview](#overview)
- [Build](#build)
- [Run](#run)
- [Options](#options)
- [Example](#example)
- [Credits](#credits)

# Overview
Generates TLS certificates for use in etcd clusters. Certificates are exposed through a volume in the container, `/app/etcd-ca`. 

# Build
`docker build -t etcd-bootstrap .`

# Run
`docker run -e DOMAIN=example.com -e NODE_NAME1=etcd1 -e NODE_NAME2=etcd2 -e NODE_NAME3=etcd3 etcd-bootstrap:local`

# Options

* **DOMAIN** 
    * Required
    * Summary: Domain name for the certificate
    * Valid Values: Any valid domain name

* **NODE_NAME** 
    * Required
    * Summary: Name of the target node
    * Valid Values: Any valid hostname
    * Notes: Multiple NODE_NAMEs may be specified by appending an integer, e.g., `NODE_NAME1=etcd1,NODE_NAME2=etcd2`

# Example
```
$ docker run -e DOMAIN=kindafree.me -e NODE_NAME1=etcd1 -e NODE_NAME2=etcd2 etcd-bootstrap 
Generating CA certificate...
2019/06/02 17:29:31 [INFO] generating a new CA key and certificate from CSR
2019/06/02 17:29:31 [INFO] generate received request
2019/06/02 17:29:31 [INFO] received CSR
2019/06/02 17:29:31 [INFO] generating key: rsa-2048
2019/06/02 17:29:31 [INFO] encoded CSR
2019/06/02 17:29:31 [INFO] signed certificate with serial number 275312666154127897505207875992621741499670105777
Generating certificate for etcd1.kindafree.me
2019/06/02 17:29:31 [INFO] generate received request
2019/06/02 17:29:31 [INFO] received CSR
2019/06/02 17:29:31 [INFO] generating key: rsa-2048
2019/06/02 17:29:31 [INFO] encoded CSR
2019/06/02 17:29:31 [INFO] signed certificate with serial number 224337293592703259894421271370400042223042564588
Generating certificate for etcd2.kindafree.me
2019/06/02 17:29:31 [INFO] generate received request
2019/06/02 17:29:31 [INFO] received CSR
2019/06/02 17:29:31 [INFO] generating key: rsa-2048
2019/06/02 17:29:32 [INFO] encoded CSR
2019/06/02 17:29:32 [INFO] signed certificate with serial number 286157695423454448952772984873195666709864159820
The following files were generated at /app/etcd-ca
total 40
4 -rw------- 1 root root 1675 Jun  2 17:41 etcd2-key.pem
4 -rw-r--r-- 1 root root  928 Jun  2 17:41 etcd2.csr
4 -rw-r--r-- 1 root root 1204 Jun  2 17:41 etcd2.pem
4 -rw------- 1 root root 1675 Jun  2 17:41 etcd1-key.pem
4 -rw-r--r-- 1 root root  928 Jun  2 17:41 etcd1.csr
4 -rw-r--r-- 1 root root 1204 Jun  2 17:41 etcd1.pem
4 -rw-r--r-- 1 root root  112 Jun  2 17:41 ca-config.json
4 -rw------- 1 root root 1675 Jun  2 17:41 ca-key.pem
4 -rw-r--r-- 1 root root  883 Jun  2 17:41 ca.csr
4 -rw-r--r-- 1 root root 1119 Jun  2 17:41 ca.pem

```

# Credits
Credit to [pcocc](https://pcocc.readthedocs.io/en/latest/deps/etcd-production.html) for providing clear documentation on certificate generation.
