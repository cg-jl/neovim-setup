.PHONY: main

init.lua: fnl/
	mkdir -p lua && \
	NVIM_CONFIG_THEME=monokai fennel --require-as-include --no-compiler-sandbox --compile fnl/main.fnl > init.lua

all: init.lua
