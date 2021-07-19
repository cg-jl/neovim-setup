FNL_FILES := $(shell find fnl -name '*.fnl')
LUA_FILES := $(patsubst fnl/%.fnl, lua/%.lua, $(FNL_FILES))
FMT := $(patsubst %,format/%, $(FNL_FILES))




lua/%.lua: fnl/%.fnl
	@echo "Compiling $^"
	@mkdir -p $(dir $@) && \
	fennel --compile $^ > $@


.PHONY: all_files
.PHONY: clean



all_files: $(LUA_FILES)

clean:
	@rm -rf lua

all: all_files
