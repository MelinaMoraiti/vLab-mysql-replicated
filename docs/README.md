# vLab-MySQL-Replication using Docker 🐳

# Description:
Implementation of a replicated MySQL setup, hosted in a virtual laboratory using docker environment. The lab includes network isolation, automated service execution (with shell scripts), and resource configuration for memory requirements.

# Contents:
Our project contains the following:

- A docker-compose.yaml file that describes the services we use. Specifically, we use 3 containers, a master which is our main hub and two slave containers that are used to replicate the masters data.

- A setup script that is responsible for the following: 
    1. Reading and exporting environment variables for the master and two slave MySQL instanses.
    2. Building and starting the docker containers.
    3. Starting MySQL on the master container.
    4. Creating a replication user on the master container.
    5. Starting MySQL on the slave containers.
    6. Configuring the slave containers. 

- A stop script that stops the running containers

- A testing script that:
    1. Accesses the master and runs mysql commands that create a table in a database, and inserts dummy data to it.
    2. Exits the master and accesses the slaves.
    3. Shows the tables in the database that have been replicated to the slaves.
    4. Displays the replicated data in the tables.

- A Makefile that runs the setup script, a docker ps command that shows that all containers are up and running, the testing script and then the stop script. It essentialy demonstrates how our project works.