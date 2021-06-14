const std = @import("std");
pub const Sys = @import("sys.zig").Sys;

pub fn panic(msg: []const u8) void {
    std.io.getStdOut().writer().writeAll("\x1B[2J") catch {};
    std.io.getStdOut().writer().writeAll("\x1B[h") catch {};
    std.io.getStdOut().writer().writeAll(msg) catch {};

    std.os.exit(1);
    // std.builtin.default_panic(msg, null);
}
