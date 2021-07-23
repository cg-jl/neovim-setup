.PHONY: main

main:
	fennel --require-as-include --compile fnl/main.fnl > init.lua

all: main
