#!/bin/bash
if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi

if [ "$AUTH" == "yes" ]; then
    export mongodb='/usr/bin/mongod --nojournal --auth --rest'
else
    export mongodb='/usr/bin/mongod --nojournal --rest'
fi

if [ ! -f /data/db/mongod.lock ]; then
    eval $mongodb
else
    export mongodb=$mongodb' --dbpath /data/db' 
    rm /data/db/mongod.lock
    mongod --dbpath /data/db --repair && eval $mongodb
fi

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin -u admin -p $PASS --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "========================================================================"
echo "=> Creating a database user with a ${_word} password in MongoDB"
echo "========================================================================"
mongo admin -u admin -p $MONGODB_PASS --eval "use presenter-staging;"
mongo admin -u admin -p $MONGODB_PASS --eval "db.addUser('staging', 'gezzon14');"
mongo admin -u admin -p $MONGODB_PASS --eval "db.auth('staging', 'gezzon14');"
