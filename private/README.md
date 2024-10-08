A Docker Compose file and some auxiliary scripts are provided for running a [Polymesh Private](https://polymesh.network/) development environment via `docker compose`

## Prerequisites

Docker 19.03.0+ for you platform installed and running. Download and setup instructions can be found here: <https://docs.docker.com/get-docker/>

Docker compose in version 1.10.0+. You can check your current version with command:

```sh
$ docker compose version
```

The Docker daemon needs to be running before Compose will work. (Try `docker ps` to see if the daemon responds)

## Running

Firstly you'll need to clone this repo to your local machine, using:

```bash
git clone git@github.com:LedgerLink-ai/rails_polymesh_blockchain.git

cd polymesh-private-dev-env
```

Original repo: https://github.com/PolymeshAssociation/polymesh-private-dev-env.git

Following the original instructions you can do it via docker-compose or use makefile, for makefile follow [Makefile Document](./README_MAKEFILE).

You can now use `docker compose up -d` to bring up the services. `docker compose down` will stop them.

The default .env file is provided as a symlink. If you want to use different versions, overwrite it or link to any other existing env files in the ./envs directory. Alternatively a file patch can be given explicitly to docker compose, e.g. `docker compose --env-file=envs/1.0 up -d`.

This command will bring up:

- Single node Polymesh Private chain in a dev mode
- Polymesh Private REST API
- Polymesh Private Proof API
- Hashicorp Vault as a signing manager for the Polymesh Rest API
- Subquery indexer
- Subquery graphql server
- Postgres (subquery dependency)

This set of services should allow for testing most integrations.

Bear in mind that it will take a couple of minutes during the first run to set up everything.

Go to http://localhost:3030/status/pp to monitor if everything has fully initialized. Once everything is green and the top message says _All Systems Operational_ you should be good to go.

The following signers, with keys stored in Vault, are created and can be used to sign transactions. They will have proper CDD claim and some POLYX.

- sender-1
- receiver-1
- mediator-1
- venue-owner-1

## Statefulness

The Docker Compose file uses named volumes to persist state where applicable. This is true for:

- Polymesh Private node
- Hashicorp Vault
- Postgresql

As a result, the entire environment will retain its state during restarts.

```sh
$ docker volume ls
DRIVER    VOLUME NAME
local     polymesh-private_pp-chain-data
local     polymesh-private_pp-psql-data
local     polymesh-private_pp-rest-api-accounts-init
local     polymesh-private_pp-uptime-kuma-data
local     polymesh-private_pp-vault-log-volume
local     polymesh-private_pp-vault-root-token
local     polymesh-private_pp-vault-volume
```

If you want to start from scratch, you need to stop the containers and remove these volumes.

```sh
docker compose down --volumes
```

## Additional Notes

To access the Vault UI at http://localhost:8200, you need the root token. You can get it with this command:

```sh
docker compose logs vault-init 
```

It should be printed on the last line.

## List of web interfaces exposed to localhost along with their default ports:

- http://localhost:3000 <-- Subquery GraphQL
- http://localhost:3001 <-- Polymesh Rest API
- http://localhost:8080/swagger-ui/ <-- Polymesh Proof API
- http://localhost:8020 <-- Hashicorp Vault, signing manager

## List of the remaining services exposed to localhost along with their default ports:

- localhost:9944 <-- polymesh-private WebSocket endpoint
- localhost:9933 <-- polymesh-private HTTP endpoint
- localhost:30333 <-- polymesh-private p2p endpoint
