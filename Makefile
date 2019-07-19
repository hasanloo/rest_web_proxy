#############################
# Docker machine states
#############################

COMPOSE_ENV=COMPOSE_HTTP_TIMEOUT=240
COMPOSE:=env $(COMPOSE_ENV) docker-compose -f ./docker-compose.yml

.PHONY: all test clean

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

status:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f

enter-container:
	$(COMPOSE) run --rm --no-deps -e USER=test web sh

migrate:
	$(COMPOSE) run --rm --no-deps -e USER=test web mix ecto.migrate

test:
	$(COMPOSE) run --rm --no-deps -e USER=test -e MIX_ENV=test web mix test test/

test-coverage:
	$(COMPOSE) run --rm --no-deps -e USER=test -e MIX_ENV=test web mix coveralls

test-coverage-detail:
	$(COMPOSE) run --rm --no-deps -e USER=test -e MIX_ENV=test web mix coveralls.detail

code-lint:
	$(COMPOSE) run --rm --no-deps -e USER=test -e MIX_ENV=dev web mix credo --strict

type-analysis:
	$(COMPOSE) run --rm --no-deps -e USER=test -e MIX_ENV=dev web mix dialyzer

doc-analysis:
	$(COMPOSE) run --rm --no-deps -e USER=test -e MIX_ENV=dev web mix inch

