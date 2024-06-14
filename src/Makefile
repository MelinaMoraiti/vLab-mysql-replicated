# Define the default target that will run all the steps
all: setup docker_ps testing stop

# Target to run setup.sh
setup:
	./setup.sh

# Target to run 'docker ps'
docker_ps:
	docker ps

# Target to run testing.sh
testing:
	./testing.sh

# Target to run stop.sh
stop:
	./stop.sh

# Phony targets to avoid conflicts with files named setup, docker_ps, etc.
.PHONY: all setup docker_ps testing stop