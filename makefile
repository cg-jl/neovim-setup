.PHONY: main

main:
	mkdir -p lua && \
	NVIM_CONFIG_THEME=monokai fennel --require-as-include --no-compiler-sandbox --compile fnl/main.fnl > lua/main.lua

all: main
