# Setting Up a Replicated MySQL Environment with Docker 🐳

## Prerequisites
Before you begin, ensure you have the following installed on your system:
- Docker
- Docker Compose
- Git

## 🚀 Installation Steps
Clone the repository to your local machine:
```bash
git clone https://github.com/MelinaMoraiti/vLab-mysql-replicated.git
```
Go to the directory of the project
```bash
cd vLab-mysql-replicated
```
This command will grant execute permissions to both setup.sh and stop.sh scripts
```bash
chmod +x src/setup.sh src/stop.sh
```
Run the following command to execute the setup.sh script which is responsible to build, start the Docker containers and also handle the setup of the MySQL replication.
```bash
./src/setup.sh
```

## ⛔ Stopping the environment
To stop the Docker containers and remove volumes, run:
```bash
./src/stop.sh
```

