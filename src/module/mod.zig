pub usingnamespace @import("../lua.zig");

const c = @cImport({
    @cInclude("stdlib.h");
    @cInclude("stdio.h");
});

const std = @import("std");
const os = std.os;

pub fn panic(msg: []const u8) void {
    std.io.getStdOut().writer().writeAll("\x1B[2J") catch {};
    std.io.getStdOut().writer().writeAll("\x1B[h") catch {};
    std.io.getStdOut().writer().writeAll(msg) catch {};

    os.exit(1);
    // std.builtin.default_panic(msg, null);
}

/// Math utilities
pub const Math = struct {
    /// @syn     :: zetch.avg(<num>, <num>, ...)
    /// @returns :: the average of <num> decimals
    pub fn m_avg(s: ?*lua_State) callconv(.C) c_int {
        const n = lua_gettop(s);
        var sum: lua_Number = 0;
        var i: c_int = 1;
        while (i <= n) : (i += 1) {
            var is_num: c_int = 0;
            const num: lua_Number = lua_tonumberx(s, i, &is_num);
            if (is_num != 0)
                sum += num;
        }
        const avg: lua_Number = sum / @intToFloat(lua_Number, n);
        lua_pushnumber(s, avg);
        lua_pushnumber(s, sum);
        return 2;
    }

    /// @syn     :: zetch.add(<num>, <num>, ...)
    /// @returns :: the sum of <num> decimals
    pub fn m_sum(s: ?*lua_State) callconv(.C) c_int {
        const n = lua_gettop(s);
        var sum: lua_Number = 0;
        var i: c_int = 1;
        while (i <= n) : (i += 1) {
            var is_num: c_int = 0;
            const num: lua_Number = lua_tonumberx(s, i, &is_num);
            if (is_num != 0)
                sum += num;
        }
        lua_pushnumber(s, sum);
        return 1;
    }
};

/// System utilities
pub const Sys = struct {

    /// zetch.user()
    /// returns username
    pub fn m_user(s: ?*lua_State) callconv(.C) c_int {
        const user = c.getenv("USER");
        var res = lua_pushstring(s, user);
        if (res == null)
            panic("error: failed to get username from $USER\n");
        return 1;
    }

    pub fn m_format(s: ?*lua_State) callconv(.C) c_int {

        _ = lua_getfield(s, (-@as(c_int, 1000000) - @as(c_int, 1000)), "ascii");
        // _ = lua_getfield(s, -@as(c_int, 1), "sep");
        var ascii: [*c]const u8 = lua_tolstring(s, (-@as(c_int, 1)), null);

        lua_settop(s, (-(@as(c_int, 0)) - @as(c_int, 1)));
        var info: [*c]const u8 = lua_tolstring(s, (@as(c_int, 1)), null);

        _ = c.printf("%s\n",
            info);

        return 1;
    }
};
