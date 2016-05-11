#!/bin/sh

source /etc/erpico.conf

for x in changeLog*.xml; do
  SUFFIX=`echo $x | sed "s/^changeLog\(.*\)\.xml/\1/"`
#  if
  CMD="migrate" 
  LEN=$(echo ${#SUFFIX})
  if [ $LEN -gt 1 ]; then
    CMD="$CMD.${SUFFIX:1}"
  fi

  eval ant $CMD -Djboss.home.dir=\"$JBOSS_HOME\" \
                -Djboss.server.base.dir=\"$JBOSS_BASE_DIR\" \
                -Derpico.db_host=\"$db_host\" \
                -Derpico.db_user=\"$db_user\" \
                -Derpico.db_password=\"$db_password\" \
                -Derpico.db_port=\"$db_port\" \
                -Derpico.db_schema=\"$db_schema\" 
done


