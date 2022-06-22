.PHONY: main

THEME ?= material

main:
	mkdir -p lua && \
	NVIM_CONFIG_THEME=$(THEME) fennel --require-as-include --no-compiler-sandbox --compile fnl/main.fnl > init.lua
	nvim --headless -c PackerCompile -c q

