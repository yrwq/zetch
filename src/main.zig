const std = @import("std");
const print = std.debug.print;
const fetch = @import("fetch.zig");

pub fn main() anyerror!void {
    const alloc = std.heap.c_allocator;

    const os = fetch.os(alloc);
    const kernel = fetch.kernel(alloc);
    const shell = fetch.shell();

    print("{s}\n", .{os});
    print("{s}\n", .{kernel});
    print("{s}\n", .{shell});
}
