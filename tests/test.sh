#!/bin/bash
set -e

vagrant up --provision

ansible-galaxy install -r requirements.yml -p ./roles --force

ansible-playbook -i inventory.ini test.yml

ansible-playbook -i inventory.ini test.yml \
  | grep -q 'changed=0.*failed=0' \
  && (echo 'Idempotence test: pass' && exit 0) \
  || (echo 'Idempotence test: fail' && exit 1)

./wtfc -T 300 -S 0 -I 2 curl -f http://192.168.33.84:10081

curl -o /dev/null -s -w "%{http_code}\n" http://192.168.33.84:10081 \
 | grep -qE '302|200' \
  && (echo 'curl test: pass' && exit 0) \
  || (echo 'curl test: fail' && exit 1)

vagrant destroy -f
