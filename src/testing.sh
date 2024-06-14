#!/bin/bash

# Function to run MySQL commands inside a Docker container and check for empty set
run_mysql_commands() {
  local container=$1
  shift
  local commands=$@
  
  # Capture the output of the MySQL command
  output=$(sudo docker exec -i $container bash -c "mysql -uroot -ptestpass -e \"$commands\"")
  
  # Print the output
  echo "$output"
  
  # Check if the output contains 'Empty set'
  if echo "$output" | grep -q "Empty set"; then
    echo "The query returned an empty set."
  fi
}

# Commands to run on the master
MASTER_COMMANDS="
  use mydb;
  show tables;
  create table users(id INT auto_increment primary key, name varchar(100), email varchar(100));
  insert into users(name, email) values('John Doe', 'John@unwa.gr'), ('Jane Doe', 'Jane@uniwa.gr');
  select * from users;
"

# Commands to run on the slaves
SLAVE_COMMANDS="
  use mydb;
  show tables;
  select * from users;
"

# Execute commands on mysql_master
echo "Running commands on mysql_master"
run_mysql_commands mysql_master "$MASTER_COMMANDS"

# Execute commands on mysql_slave1
echo "Running commands on mysql_slave1"
run_mysql_commands mysql_slave1 "$SLAVE_COMMANDS"

# Execute commands on mysql_slave2
echo "Running commands on mysql_slave2"
run_mysql_commands mysql_slave2 "$SLAVE_COMMANDS"