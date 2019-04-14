# Verdaccio

This is the repository for a verdaccio + ldap docker image that runs on **Node 8**.

This bypasses `Node 10 issues` with a core `ldap` package.

This repository contains:
- `Dockerfile` - The Dockerfile specifying how to run verdaccio
- `yarn.lock` - The yarn.lock file specifying the package versions to install
- `package.json` - The package.json specifying the dependency packages and versions
- `config.yaml` - The config.yaml file used by the verdaccio server

---
## Production

For production use with Docker make sure the verdaccio storage directory has the correct permissions.

Verdaccio in Docker runs under the user `9999:9999` the mounted storage directory needs to match those permissions.

### Setup verdaccio storage directory permissions

- `ssh your.storage.mount.com`
- `sudo chown -R 9999:9999 /your/storage/for/verdaccio`
- `cd /your/storage/for/verdaccio`
- `find . -type f |xargs sudo chmod 644`
- `find . -type d |xargs sudo chmod 755`

---
## Updating

To update the verdaccio version or configuration, use the following commands.

All commands below assume that the current directory is the root of this repository.

### Updating Verdaccio Package Versions

- Edit the version numbers in `package.json`
- Run `yarn install` to update the `yarn.lock` file
- Build the verdaccio Dockerfile `(See Development below)`
- Commit changes `(optional)`

### Update Verdaccio Configuration

- Edit `config.yaml` to change the verdaccio configuration
- Build the verdaccio Dockerfile `(See Development below)`
- Commit changes `(optional)`

---
## Development

To run verdaccio locally, use the following commands.

All commands below assume that the current directory is the root of this repository.

### Setup a local verdaccio storage directory

Verdaccio as the `current user on your machine` the mounted storage directory needs to match those permissions.

- `mkdir -p verdaccio/storage`
- `sudo chown -R <your-user>:<your-group> verdaccio`
- `cd verdaccio`
- `find . -type f |xargs sudo chmod 644`
- `find . -type d |xargs sudo chmod 755`

### Run verdaccio locally

- Ensure that `config.yaml` `self_path: '/'` is **not set**.
- `./node_modules/verdaccio/bin/verdaccio --config config.yaml`

### Debug verdaccio in VS Code

- Open the root of this folder with `code .`
- Run `Verdaccio` command in `launch.json` (Available to run in the `Debug` sidebar)


## Docker Development

To build or run the Dockerfile in local development mode, use the following commands.

All commands below assume that the current directory is the root of this repository.

### Build the verdaccio Dockerfile
- `docker build --tag=verdaccio-ldap-8 .`

### Setup a local verdaccio storage mount

Verdaccio in Docker runs under the user `9999:9999` the mounted storage directory needs to match those permissions.

- `mkdir -p verdaccio/storage`
- `rsync -avz -P your.storage.mount.com:/your/storage/for/verdaccio/.sinopia-db.json verdaccio/storage/`
- `rsync -avz -P your.storage.mount.com:/your/storage/for/verdaccio/storage/@yourscope verdaccio/storage/`
- `sudo chown -R 9999:9999 verdaccio`
- `cd verdaccio`
- `find . -type f |xargs sudo chmod 644`
- `find . -type d |xargs sudo chmod 755`

### Run the verdaccio Dockerfile with a local verdaccio storage mount
- Build the verdaccio Dockerfile
- Ensure that `config.yaml` `self_path: '/'` is **set**
- `docker run -it --mount src="$(pwd)/verdaccio",target=/verdaccio,type=bind --rm --name verdaccio -p 4873:4873 verdaccio-ldap-8`

### Run the verdaccio Dockerfile with a local verdaccio storage mount and interactive shell
- Build the verdaccio Dockerfile
- Ensure that `config.yaml` `self_path: '/'` is **set**
- `docker run --rm -it --mount src="$(pwd)/verdaccio",target=/verdaccio,type=bind verdaccio-ldap-8 /bin/sh`