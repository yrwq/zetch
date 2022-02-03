const std = @import("std");
const file_exists = @import("../util.zig").file_exists;

pub fn get(allocator: std.mem.Allocator) ![]const u8 {
    var file: std.fs.File = undefined;
    var os_name: []const u8 = "Btw";
    var os_name_prefix: []const u8 = undefined;

    if (file_exists("/etc/lsb-release")) {
        file = try std.fs.openFileAbsolute(
            "/etc/lsb-release",
            .{ .read = true },
        );
        os_name_prefix =
            \\DISTRIB_DESCRIPTION="
        ;
    } else if (file_exists("/etc/os-release")) {
        file = try std.fs.openFileAbsolute(
            "/etc/os-release",
            .{ .read = true },
        );
        os_name_prefix =
            \\PRETTY_NAME="
        ;
    }

    const file_read = try file.readToEndAlloc(allocator, 0x200);
    file.close();
    defer allocator.free(file_read);

    var lines = std.mem.tokenize(u8, file_read, "\n");

    while (true) {
        var line = lines.next() orelse break;
        if (std.mem.startsWith(u8, line, os_name_prefix)) {
            os_name = line[os_name_prefix.len .. line.len - 1];
        }
    }

    const res = try allocator.dupe(u8, os_name);

    return res;
}
