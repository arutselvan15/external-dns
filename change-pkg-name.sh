#!/bin/bash

FILES=$(find . -type f -exec grep -H 'sigs.k8s.io/external-dns' {} \; | grep -v -e Docker -e Makefile  -e 'notes' -e 'change-pkg-name' -e 'rollback-pkg-name' -e 'go.mod' -e 'go.sum' -e 'golangci.yml' -e '.idea' -e '\.git' | awk '{ print substr( $1, 1, length($1)-1 ) }' | uniq )

for file in ${FILES}
do
  echo "patching file ${file}"
  sed 's~sigs.k8s.io/external-dns~github.com/arutselvan15/external-dns~g' ${file} > ${file}-temp
  mv ${file}-temp ${file}
done