# Setting Up a Replicated MySQL Environment with Docker 🐳

## Prerequisites
Before you begin, ensure you have the following installed on your system:
- Docker
- Docker Compose
- Git
  
**Note:** The bash shell scripts are designed to run on a **Linux** environment. While Docker is cross-platform, (Docker Desktop is the version of Docker designed for macOS and Windows), the scripts provided here are tailored specifically for Linux systems.
  
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
chmod +x src/setup.sh src/stop.sh src/testing.sh
```
Run the following commands to execute the setup.sh script which is responsible to build, start the Docker containers, create data volumes for MySQL and also handle the setup needed for MySQL replication.
```bash
cd src
./setup.sh
```

## ⛔ Stopping the environment
To stop the Docker containers and remove volumes, run:
```bash
./stop.sh
```

