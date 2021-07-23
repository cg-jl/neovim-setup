FNL_FILES := $(shell find fnl -name '*.fnl')
FMT := $(patsubst %,format/%, $(FNL_FILES))




lua/%.lua: fnl/%.fnl
	@echo "Compiling $^"
	@mkdir -p $(dir $@) && \
	fennel --require-as-include --compile $^ > $@


.PHONY: all_files
.PHONY: clean
.PHONY: main

main:
	fennel --require-as-include --compile fnl/main.fnl > init.lua



clean:
	@rm -rf lua

all: main
