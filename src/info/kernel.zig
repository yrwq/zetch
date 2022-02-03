const std = @import("std");
const file_exists = @import("../util.zig").file_exists;

pub fn get(allocator: std.mem.Allocator) ![]const u8 {
    var file: std.fs.File = undefined;

    if (file_exists("/proc/version")) {
        file = try std.fs.openFileAbsolute("/proc/version", .{ .read = true });
    }

    const file_read = try file.readToEndAlloc(allocator, 0x100);
    file.close();
    defer allocator.free(file_read);

    var info = std.mem.tokenize(u8, file_read, " ");
    var kernel_ver: []const u8 = undefined;
    while (true) {
        var word = info.next() orelse break;
        if (std.mem.eql(u8, word, "version")) {
            kernel_ver = info.next().?;
            break;
        }
    }

    const res = try allocator.dupe(u8, kernel_ver);
    errdefer allocator.free(res);

    return res;
}
