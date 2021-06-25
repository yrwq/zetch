usingnamespace @cImport({
    @cInclude("lua.h");
    @cInclude("lauxlib.h");
    @cInclude("lualib.h");
});

const mod = @import("module/mod.zig");

const sys = mod.Sys;

export fn luaopen_libzetch(s: ?*lua_State) callconv(.C) c_int {
    lua_newtable(s);

    lua_pushcfunction(s, sys.m_user);
    lua_setfield(s, -2, "user");

    return 1;
}
