# Makefile

.PHONY: all
all: test

.PHONY: test
test:
	terraform validate

.PHONY: fmt
fmt:
	terraform fmt

.PHONY: format
format: fmt
