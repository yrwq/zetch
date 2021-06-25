usingnamespace @cImport({
    @cInclude("lua.h");
    @cInclude("lauxlib.h");
    @cInclude("lualib.h");
});

const panic = @import("mod.zig").panic;

const c = @cImport({
    @cInclude("stdlib.h");
    @cInclude("stdio.h");
});

const std = @import("std");
const os = std.os;

/// System utilities
pub const Sys = struct {

    /// syn     :: zetch.user()
    /// returns :: username
    pub fn m_user(s: ?*lua_State) callconv(.C) c_int {
        const user = c.getenv("USER");
        var res = lua_pushstring(s, user);
        if (res == null)
            panic("error: failed to get username from $USER\n");
        return 1;
    }
};
