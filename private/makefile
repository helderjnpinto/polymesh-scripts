# Makefile for managing the Polymesh Private development environment

# Default environment configuration version
ENV_VERSION ?= 1.2

# Environment file path
ENV_FILE = envs/$(ENV_VERSION)

# Default target
.DEFAULT_GOAL := help

# Start the environment
.PHONY: up
up:
	@echo "Starting Polymesh Private environment with configuration version $(ENV_VERSION)..."
	@docker compose --env-file=$(ENV_FILE) up -d

# Stop the environment
.PHONY: down
down:
	@echo "Stopping Polymesh Private environment..."
	@docker compose --env-file=$(ENV_FILE) down

# View logs
.PHONY: logs
logs:
	@echo "Tailing logs for all services..."
	@docker compose --env-file=$(ENV_FILE) logs -f

# Rebuild and start the environment
.PHONY: rebuild
rebuild:
	@echo "Rebuilding and starting Polymesh Private environment with configuration version $(ENV_VERSION)..."
	@docker compose --env-file=$(ENV_FILE) up -d --build

# Clean up containers and volumes
.PHONY: clean
clean:
	@echo "Stopping and removing containers, networks, and volumes..."
	@docker compose --env-file=$(ENV_FILE) down --volumes

# Check status of the services
.PHONY: status
status:
	@echo "Checking the status of the services..."
	@curl -s http://localhost:3030/status/pp | jq .

# Access Vault root token
.PHONY: vault-token
vault-token:
	@echo "Fetching the Vault root token..."
	@docker compose --env-file=$(ENV_FILE) logs vault-init | grep 'Root Token:' | tail -1 | awk '{print $$NF}'

# Show help message
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make up           - Start the environment (default version: $(ENV_VERSION))"
	@echo "  make down         - Stop the environment"
	@echo "  make logs         - Tail logs for all services"
	@echo "  make rebuild      - Rebuild and start the environment (default version: $(ENV_VERSION))"
	@echo "  make clean        - Stop and remove containers, networks, and volumes"
	@echo "  make status       - Check the status of the services"
	@echo "  make vault-token  - Fetch the Vault root token"
	@echo "  make help         - Show this help message"
