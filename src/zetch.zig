pub usingnamespace @import("lua.zig");
const mod = @import("module/mod.zig");
const sys = mod.Sys;
const math = mod.Math;

export fn luaopen_libzetch(s: ?*lua_State) c_int {
    lua_newtable(s);

    lua_pushcfunction(s, sys.m_user);
    lua_setfield(s, -2, "user");

    return 1;
}
