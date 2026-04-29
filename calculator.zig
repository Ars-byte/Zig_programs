
const std = @import("std");
 
fn add(a: f64, b: f64) f64 { return a + b; }
fn sub(a: f64, b: f64) f64 { return a - b; }
fn mul(a: f64, b: f64) f64 { return a * b; }
fn div(a: f64, b: f64) f64 {
    if (b == 0.0) {
        std.debug.print("Error: division by zero!\n", .{});
        return 0.0;
    }
    return a / b;
}
fn mod(a: f64, b: f64) f64 { return @rem(a, b); }
fn power(base: f64, exp: u32) f64 {
    var result: f64 = 1.0;
    var i: u32 = 0;
    while (i < exp) : (i += 1) result *= base;
    return result;
}
 
pub fn main() !void {
    const stdin  = std.io.getStdIn().reader();
    var buf: [64]u8 = undefined;
 
    std.debug.print("\n╔═════════════════════════╗\n", .{});
    std.debug.print("║    ZIG CALCULATOR      ║\n", .{});
    std.debug.print("╚═════════════════════════╝\n", .{});
    std.debug.print("Operations: +  -  *  /  %  ^\n\n", .{});
 
    // --- Read first number ---
    std.debug.print("Enter first number: ", .{});
    const raw_a = try stdin.readUntilDelimiter(&buf, '\n');
    const a = try std.fmt.parseFloat(f64, std.mem.trim(u8, raw_a, &std.ascii.whitespace));
 
    // --- Read operator ---
    std.debug.print("Enter operator (+, -, *, /, %%, ^): ", .{});
    const raw_op = try stdin.readUntilDelimiter(&buf, '\n');
    const op = std.mem.trim(u8, raw_op, &std.ascii.whitespace);
 
    // --- Read second number ---
    std.debug.print("Enter second number: ", .{});
    const raw_b = try stdin.readUntilDelimiter(&buf, '\n');
    const b = try std.fmt.parseFloat(f64, std.mem.trim(u8, raw_b, &std.ascii.whitespace));
 
    const result: f64 = blk: {
        if (std.mem.eql(u8, op, "+")) break :blk add(a, b);
        if (std.mem.eql(u8, op, "-")) break :blk sub(a, b);
        if (std.mem.eql(u8, op, "*")) break :blk mul(a, b);
        if (std.mem.eql(u8, op, "/")) break :blk div(a, b);
        if (std.mem.eql(u8, op, "%")) break :blk mod(a, b);
        if (std.mem.eql(u8, op, "^")) {
            const exp: u32 = @intFromFloat(b);
            break :blk power(a, exp);
        }
        std.debug.print("Unknown operator: {s}\n", .{op});
        break :blk 0.0;
    };
 
    std.debug.print("\n─────────────────────────\n", .{});
    std.debug.print("  {d} {s} {d} = {d:.4}\n", .{ a, op, b, result });
    std.debug.print("─────────────────────────\n", .{});
}
