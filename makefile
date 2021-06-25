all:
	@sudo cp zig-out/lib/libzetch.so /usr/local/lib/lua/5.4/libzetch.so
	@cp examples/init.lua ~/.config/zetch/init.lua
	@zig-out/bin/zetch
