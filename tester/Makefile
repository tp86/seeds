.PHONY: setup

deps = luaunit.lua lfs.so

lib_dir = $(PWD)/lib
libs = $(addprefix $(lib_dir)/,$(deps))
lib_src_dir = $(PWD)/.libsrc
lua_version = $(shell lua -e 'print(_VERSION:match("%d+%.%d+"))')

setup: $(libs)

$(lib_src_dir)/luaunit: url=https://github.com/bluebird75/luaunit
$(lib_dir)/luaunit.lua: src_loc=$(@F)

$(lib_src_dir)/lfs: url=https://github.com/lunarmodules/luafilesystem
$(lib_dir)/lfs.so: src_loc=src/$(@F)

$(lib_src_dir)/%:
	git clone $(url) $@

$(lib_dir)/%.lua: $(lib_src_dir)/%
	@mkdir -p $(@D)
	cp -r $</$(src_loc) $@

$(lib_dir)/%.so: $(lib_src_dir)/%
	@mkdir -p $(@D)
	$(MAKE) -C $< -e LUA_VERSION=$(lua_version)
	cp -r $</$(src_loc) $@
