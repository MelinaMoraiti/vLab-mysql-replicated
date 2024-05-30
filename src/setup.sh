#!/bin/bash

export $(grep -v '^#' ./master/mysql_master.env | xargs)
export $(grep -v '^#' ./slave/mysql_slave.env | xargs)

docker-compose build
docker-compose up -d

wait_for_mysql() {
    local container_name=$1
    echo "Waiting for $container_name database connection..."
    until docker exec $container_name mysql -u root -p${MYSQL_ROOT_PASSWORD} -e ';' &>/dev/null; do
        sleep 2
    done
    echo "$container_name is ready"
}

wait_for_mysql mysql_master

#Create replication user on master
echo "Creating replication user on master..."
priv_stmt="CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT REPLICATION SLAVE ON *.* TO '${MYSQL_USER}'@'%'; FLUSH PRIVILEGES;"
docker exec mysql_master mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "$priv_stmt"

wait_for_mysql mysql_slave

#Get master status
MS_STATUS=$(docker exec mysql_master mysql -u root -p${MYSQL_ROOT_PASSWORD} -e 'SHOW MASTER STATUS \G')
CURRENT_LOG=$(echo "$MS_STATUS" | grep 'File:' | awk '{print $2}')
CURRENT_POS=$(echo "$MS_STATUS" | grep 'Position:' | awk '{print $2}')

configure_slave() {
    local slave_name=$1
    echo "Configuring $slave_name..."
    start_slave_stmt="CHANGE MASTER TO MASTER_HOST='mysql_master',MASTER_PORT=3306,MASTER_USER='${MYSQL_USER}',MASTER_PASSWORD='${MYSQL_PASSWORD}',MASTER_LOG_FILE='${CURRENT_LOG}',MASTER_LOG_POS=${CURRENT_POS}; START SLAVE;"
    docker exec $slave_name mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "$start_slave_stmt"
    echo "Checking $slave_name status..."
    docker exec $slave_name mysql -u root -p${MYSQL_ROOT_PASSWORD} -e 'SHOW SLAVE STATUS \G'
}

#Configure slave
configure_slave mysql_slave

echo "MySQL replication setup is complete"