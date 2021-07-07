const std = @import("std");

pub const l = @cImport({
    @cInclude("lua.h");
    @cInclude("lauxlib.h");
    @cInclude("lualib.h");
});

pub fn alloc(ud: ?*c_void, ptr: ?*c_void, osize: usize, nsize: usize) callconv(.C) ?*c_void {
    const c_alignment = 16;
    const allocator = @ptrCast(*std.mem.Allocator, @alignCast(@alignOf(std.mem.Allocator), ud));
    if (@ptrCast(?[*]align(c_alignment) u8, @alignCast(c_alignment, ptr))) |previous_pointer| {
        const previous_slice = previous_pointer[0..osize];
        if (osize >= nsize) {
            return allocator.alignedShrink(previous_slice, c_alignment, nsize).ptr;
        } else {
            return (allocator.reallocAdvanced(previous_slice, c_alignment, nsize, .exact) catch return null).ptr;
        }
    } else {
        return (allocator.alignedAlloc(u8, c_alignment, nsize) catch return null).ptr;
    }
}

pub fn new_state(allocator: *std.mem.Allocator) !*l.lua_State {
    return l.lua_newstate(alloc, allocator) orelse return error.OutOfMem;
}
