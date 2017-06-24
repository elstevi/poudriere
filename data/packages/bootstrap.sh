#!/bin/sh

export SSL_NO_VERIFY_PEER=1

REPODIR="/usr/local/etc/pkg/repos"
CERTDIR="/usr/local/etc/pkg/certs"
FETCH="fetch --no-verify-peer"
PKGURL="https://pkg.douglas-enterprises.com/"
REPOFILE="pkg.douglas-enterprises.com.conf"
REPOCERT="pkg.douglas-enterprises.com.cert"

mkdir -p ${REPODIR} ${CERTDIR}
${FETCH} -o ${REPODIR} ${PKGURL}${REPOFILE} 
${FETCH} -o ${CERTDIR} ${PKGURL}${REPOCERT}

pkg update -f
