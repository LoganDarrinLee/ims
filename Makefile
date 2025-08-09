SHELL := /bin/bash

.PHONY: setup stop build run dump_schema new_migration migrate

setup: 
	scripts/setup.sh 	# Start the Postgres container

stop:
	scripts/breakdown.sh	# Stop and remove the container

build:
	scripts/build.sh

run: 
	scripts/run.sh # Run app in local docker container.

dump_schema:
	scripts/dump_schema.sh 
	# Grab and dump schema in the ./internal/db/schema/schema.sql file to view current schema

new_migration:
	scripts/new_migration.sh $(file)

migrate:
	scripts/migrate.sh && scripts/dump_schema.sh

