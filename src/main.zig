const l = @cImport({
    @cInclude("lua.h");
    @cInclude("lualib.h");
    @cInclude("lauxlib.h");
});

const std = @import("std");
const gpa = std.heap.c_allocator;

pub fn main() !void {
    var L = l.luaL_newstate();
    l.luaL_openlibs(L);

    const path = try std.fmt.allocPrintZ(gpa, "{s}/zetch/init.lua", .{std.os.getenv("XDG_CONFIG_HOME")});

    if (std.os.argv.len >= 2) {
        const arg = std.mem.span(std.os.argv[1]);
        _ = l.luaL_loadfilex(L, arg, 0);
        _ = l.lua_pcallk(L, 0, l.LUA_MULTRET, 0, 0, null);
    } else {
        _ = l.luaL_loadfilex(L, path, 0);
        _ = l.lua_pcallk(L, 0, l.LUA_MULTRET, 0, 0, null);
    }
}
