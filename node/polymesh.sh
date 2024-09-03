#!/bin/bash

# Define the container name for the all-in-one service
CONTAINER_NAME="polymesh-all-in-one"

# Define the Docker Compose file location
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Function to bring up the Docker services
function up() {
    echo "Starting Polymesh services..."
    docker-compose -f $DOCKER_COMPOSE_FILE up -d
}

# Function to bring down the Docker services
function down() {
    echo "Stopping Polymesh services..."
    docker-compose -f $DOCKER_COMPOSE_FILE down
}

# Function to clean up Docker containers and volumes
function clean() {
    echo "Cleaning up Docker containers and volumes..."
    docker-compose -f $DOCKER_COMPOSE_FILE down -v
    docker volume prune -f
    docker system prune --volumes -f
    rm -rf polymesh-data/
    echo "Cleanup complete."
}

# Function to generate session keys and validator keys
function generate_keys() {
    echo "Generating session and validator keys..."
    
    # Start a temporary container to generate keys
    docker run --rm -v $(pwd)/polymesh-data:/polymesh-data polymeshassociation/polymesh:latest-develop-distroless \
        key generate-session > polymesh-data/session_key.txt

    docker run --rm -v $(pwd)/polymesh-data:/polymesh-data polymeshassociation/polymesh:latest-develop-distroless \
        key generate > polymesh-data/validator_key.txt

    echo "Session key generated and saved to polymesh-data/session_key.txt"
    echo "Validator key generated and saved to polymesh-data/validator_key.txt"
}

# Determine which function to call based on the provided argument
case "$1" in
    up)
        up
        ;;
    down)
        down
        ;;
    clean)
        clean
        ;;
    generate-keys)
        generate_keys
        ;;
    *)
        echo "Usage: $0 {up|down|clean|generate-keys}"
        exit 1
esac
