const l = @cImport({
    @cInclude("stdlib.h");
    @cInclude("string.h");
    @cInclude("lua.h");
    @cInclude("lualib.h");
    @cInclude("lauxlib.h");
});

const std = @import("std");

pub fn main() !void {
    var L = l.luaL_newstate();
    l.luaL_openlibs(L);

    if (std.os.argv.len >= 2) {
        const arg = std.mem.span(std.os.argv[1]);
        _ = l.luaL_loadfilex(L, arg, 0);
        _ = l.lua_pcallk(L, 0, l.LUA_MULTRET, 0, 0, null);
    } else {
        const xdg_conf = l.getenv("XDG_CONFIG_HOME");
        const zetch_conf = "/zetch/init.lua";
        const conf = l.strcat(xdg_conf, zetch_conf);
        _ = l.luaL_loadfilex(L, conf, 0);
        _ = l.lua_pcallk(L, 0, l.LUA_MULTRET, 0, 0, null);
    }
}
