const std = @import("std");
 
pub fn main() void {
    std.debug.print("╔══════════════════════════╗\n", .{});
    std.debug.print("║     Hello, World!        ║\n", .{});
    std.debug.print("╚══════════════════════════╝\n", .{});
    std.debug.print("\nWelcome to Zig programming!\n", .{});
    std.debug.print("Language version: 0.13\n", .{});
}
