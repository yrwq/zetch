const std = @import("std");

pub fn get() []const u8 {
    const shell_env = std.os.getenv("SHELL");
    var shell_bin: []const u8 = undefined;
    if (shell_env) |shell_exists| {
        var shell = std.mem.tokenize(u8, shell_exists, std.fs.path.sep_str);
        while (true) {
            shell_bin = shell.next() orelse break;
        }
    }
    return shell_bin;
}
