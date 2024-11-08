DOCKER_COMPOSE = docker compose -f docker-compose.yaml
TIMEOUT = --timeout 10

# TODO: Deniz modify all below as needed for MVP
FRONT_DIST_VOLUME_PATH = front/docker/volumes/dist
USER_MANAGEMENT_DB_VOLUME_PATH = user_management/docker/volumes/db
USER_MANAGEMENT_MEDIA_VOLUME_PATH = user_management/docker/volumes/media

VOLUMES = $(FRONT_DIST_VOLUME_PATH) \
          $(USER_MANAGEMENT_DB_VOLUME_PATH) \
          $(USER_MANAGEMENT_MEDIA_VOLUME_PATH)

.PHONY: all
all: generate_env up

.PHONY: generate_env
generate_env:
    python3 ./common/src/generate_env.py

.PHONY: up
up: create_volume_path
    $(DOCKER_COMPOSE) up --detach --build

.PHONY: down
down:
    $(DOCKER_COMPOSE) down $(TIMEOUT)

.PHONY: reup
reup: down up

.PHONY: create_volume_path
create_volume_path:
    mkdir -p $(VOLUMES)

.PHONY: delete_volume_path
delete_volume_path:
    rm -rf $(VOLUMES)
