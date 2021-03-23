# Makefile

.PHONY: all
all: test

.PHONY: test
test:
	terraform validate
