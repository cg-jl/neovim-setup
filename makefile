.PHONY: main

main:
	mkdir -p lua && \
	fennel --require-as-include --compile fnl/main.fnl > lua/main.lua

all: main
