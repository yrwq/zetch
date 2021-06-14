const builder = @import("std").build.Builder;

pub fn build(b: *builder) void {
    const mode = b.standardReleaseOptions();
    const lib = b.addSharedLibrary("zetch", "src/zetch.zig", b.version(0, 0, 1));

    lib.setBuildMode(mode);
    lib.linkSystemLibrary("c");
    lib.linkSystemLibrary("lua5.4");
    lib.install();

    const exe = b.addExecutable("zetch", "src/main.zig");
    exe.setBuildMode(mode);
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("lua5.4");
    exe.install();
}
