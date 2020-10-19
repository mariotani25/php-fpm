 
#!/bin/bash

echo -e "
#-----------------#
#  DELETE SECRET  #
#-----------------#
"
docker secret rm  db_user \
  db_root_user \
  db_root_pass \
  db_name \
  db_user \
  db_pass

echo -e "
#-----------------#
#  CREATE SECRET  #
#-----------------#
"
openssl passwd -6 -stdin <<< root | docker secret create db_root_user -
openssl passwd -6 -stdin <<< root | docker secret create db_root_pass -
openssl passwd -6 -stdin <<< db_test | docker secret create db_name -
openssl passwd -6 -stdin <<< tik | docker secret create db_user -
openssl passwd -6 -stdin <<< tik | docker secret create db_pass -

echo -e "
#----------------#
#  DEPLOY STACK  #
#----------------#
"
docker-compose up -d