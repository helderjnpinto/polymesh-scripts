# Polymesh Private Development Environment

This repository contains the configuration and setup scripts for managing the Polymesh private development environment. The environment is managed using Docker Compose and a `Makefile`, making it easy to start, stop, and maintain your development setup.

## Getting Started

### Prerequisites

Make sure you have the following installed on your machine:

- Docker
- Docker Compose
- Make
- jq (for processing JSON output in the `status` command)

### Environment Configuration

The environment configuration is stored in the `envs/` directory, with different versions available. By default, the setup uses version `1.2`. You can change this by specifying a different version when running the `make` commands.

### Usage

Here are the available commands you can use with `make`:

#### Start the Environment

```bash
make up
```

This command will start the Polymesh private development environment using the default configuration version (`1.3`).

To use a different configuration version, specify it as follows:

```bash
make up ENV_VERSION=1.3
```

#### Stop the Environment

```bash
make down
```

This command will stop the environment.

#### View Logs

```bash
make logs
```

This command will tail the logs for all services.

#### Rebuild and Start the Environment

```bash
make rebuild
```

This command will rebuild the Docker containers and start the environment. To use a different configuration version, specify it like this:

```bash
make rebuild ENV_VERSION=1.3
```

#### Clean Up Containers and Volumes

```bash
make clean
```

This command will stop the environment and remove all containers, networks, and volumes.

#### Check Status of the Services

```bash
make status
```

This command will check the status of the services by sending a request to the local endpoint.

#### Access Vault Root Token

```bash
make vault-token
```

eg:
 make vault-token
Fetching the Vault root token...
hvs.hx8xxxxxxxxxxxxxxxxxxxm8

This command will fetch the Vault root token from the logs.

### Customization

You can customize the setup by modifying the `Makefile` and the environment configuration files located in the `envs/` directory.

### Explanation

- **Makefile**: The `Makefile` uses the `--env-file` option to load the environment configuration from the specified `envs/$(ENV_VERSION)` directory. This setup allows you to easily switch between different environment configurations.
