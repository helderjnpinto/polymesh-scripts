NOT TESTED!

# Run containers for private Polymesh nodes

## All in one service

- Single Service (polymesh-all-in-one): This service runs all the necessary Polymesh roles (Validator, Archive, RPC, Full Node) within a single Docker container.
- Ports:

    - 30333: The P2P port for the node.
    - 9933: The JSON-RPC port for external interactions.
    - 9944: The WebSocket port for real-time event subscriptions.

- Command Arguments:

    - --validator: This enables the node to participate in the consensus process as a Validator.
    - --pruning archive: This ensures that the node keeps a complete history of the blockchain (acting as an Archive node).
    - --rpc-cors all, --rpc-external, --ws-external, --unsafe-rpc-external, --unsafe-ws-external: These settings allow the node to serve RPC and WebSocket requests externally, fulfilling the role of an RPC node.

### Steps to Use single instance

1. Replace your_node_key_here: Assign a valid node key to the NODE_KEY environment variable.
2. Create Data Directory: Ensure the ./polymesh-data directory exists or adjust the path to where you want the blockchain data to be stored.
3. Run Docker Compose: Use docker-compose up -d to start the node.

### Key Points

- Single Node Configuration: This setup simplifies running a Polymesh private network by consolidating all services into one node. This is ideal for development, testing, or smaller-scale deployments where running multiple nodes might be unnecessary.
- Performance Considerations: Running all services on a single node might have performance implications, particularly under heavy load. For production environments or more extensive networks, running separate nodes for each service might be preferable.

## Non all in one service

- Validator Node: This is the node that participates in the consensus process by validating transactions and adding blocks to the blockchain. The --validator flag indicates this role.
- Archive Node: This node keeps a complete history of the blockchain. The --pruning archive flag ensures that all historical data is retained.
- RPC Node: This node provides a JSON-RPC interface for interacting with the blockchain. It’s typically used for serving API requests.
- Full Node: This is a general-purpose node that maintains the full state of the blockchain but with a limited history due to the --pruning 1000 setting.

### Steps to Use all in one

1. Replace your_node_key_here: Each node should have a unique NODE_KEY. Replace your_node_key_here with actual node keys.
2. Create Data Directories: Ensure that the directories ( ./validator-data, ./archive-data, ./rpc-data, and ./full-node-data) exist or adjust the paths according to your setup.
3. Run Docker Compose: Once you have the docker-compose.prd.yml file ready, run `docker-compose up -d -f docker-compose.prd.yml` to start the Polymesh network.
This setup should allow you to run a private Polymesh network with all the necessary nodes.

> In alternative to docker commands you can use the makefile

## Using makefile

### How to Use This Setup

1. Run the Services:
    - make up

2. Stop the Services:
    - make down

3. Clean Up:
    - make clean

4. Generate Keys:
    - make generate-keys

### What Each Part Does

- Makefile: Simplifies the usage of the polymesh.sh script by providing easy-to-remember commands (make up, make down, make clean, make generate-keys).
- polymesh.sh: Handles the actual tasks like starting and stopping Docker containers, cleaning up, and generating keys

    - up: Starts the Docker services as defined in the docker-compose.yml.
    - down: Stops the running Docker services.
    - clean: Stops the services and removes the associated volumes and directories.
    - generate-keys: Runs a temporary Docker container to generate the required session and validator keys and saves them to the polymesh-data/ directory.

This setup allows for easy management of your Polymesh Docker containers and key generation, all through simple commands in your terminal.
