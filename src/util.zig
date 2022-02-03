const std = @import("std");

pub fn file_exists(path_path: []const u8) bool {
    const file = std.fs.openFileAbsolute(
        path_path,
        .{ .read = true },
    ) catch return false;
    file.close();
    return true;
}
