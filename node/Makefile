.PHONY: up down clean generate-keys

# Run all-in-one service (basic setup)
up:
	@bash polymesh.sh up docker-compose.yml

# Run full set of nodes (production setup)
up-prd:
	@bash polymesh.sh up docker-compose.prd.yml

# Stop all services for basic setup
down:
	@bash polymesh.sh down docker-compose.yml

# Stop all services for production setup
down-prd:
	@bash polymesh.sh down docker-compose.prd.yml

# Clean up Docker containers and volumes for basic setup
clean:
	@bash polymesh.sh clean docker-compose.yml

# Clean up Docker containers and volumes for production setup
clean-prd:
	@bash polymesh.sh clean docker-compose.prd.yml

# Generate session keys and validator keys
generate-keys:
	@bash polymesh.sh generate-keys
