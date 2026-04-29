// ============================================================
//  03 - Fibonacci Sequence
//  Run: zig run 03_fibonacci.zig
// ============================================================

const std = @import("std");

// --- Iterative Fibonacci ---
fn fibIterative(n: u32) u64 {
    if (n == 0) return 0;
    if (n == 1) return 1;
    var a: u64 = 0;
    var b: u64 = 1;
    var i: u32 = 2;
    while (i <= n) : (i += 1) {
        const tmp = a + b;
        a = b;
        b = tmp;
    }
    return b;
}

// --- Recursive Fibonacci (for small n) ---
fn fibRecursive(n: u32) u64 {
    if (n == 0) return 0;
    if (n == 1) return 1;
    return fibRecursive(n - 1) + fibRecursive(n - 2);
}

// --- Check if a number is a Fibonacci number ---
fn isPerfectSquare(n: u64) bool {
    const s: u64 = @intFromFloat(@sqrt(@as(f64, @floatFromInt(n))));
    return s * s == n;
}
fn isFibonacci(n: u64) bool {
    return isPerfectSquare(5 * n * n + 4) or isPerfectSquare(5 * n * n - 4);
}

pub fn main() void {
    const limit: u32 = 20;

    std.debug.print("\n╔═══════════════════════════════╗\n", .{});
    std.debug.print("  ║    FIBONACCI SEQUENCE         ║\n", .{});
    std.debug.print("  ╚═══════════════════════════════╝\n\n", .{});

    // --- Print sequence ---
    std.debug.print("First {} Fibonacci numbers:\n", .{limit});
    std.debug.print("─────────────────────────────────\n", .{});

    var i: u32 = 0;
    while (i < limit) : (i += 1) {
        const fib = fibIterative(i);
        const is_fib_str: []const u8 = if (isFibonacci(fib)) "✓" else " ";
        std.debug.print("  F({:>2}) = {:>8}  {s}\n", .{ i, fib, is_fib_str });
    }

    std.debug.print("─────────────────────────────────\n", .{});
    std.debug.print("\nRecursive check — F(10) = {}\n", .{fibRecursive(10)});

    // --- Sum of first N Fibonacci numbers ---
    var total: u64 = 0;
    var j: u32 = 0;
    while (j < limit) : (j += 1) total += fibIterative(j);
    std.debug.print("Sum of first {} Fibonacci numbers: {}\n\n", .{ limit, total });

    // --- Golden ratio approximation ---
    const f_n: f64 = @floatFromInt(fibIterative(limit));
    const f_n1: f64 = @floatFromInt(fibIterative(limit - 1));
    std.debug.print("Golden ratio ≈ F({}) / F({}) = {d:.8}\n", .{ limit, limit - 1, f_n / f_n1 });
    std.debug.print("Actual φ                    = 1.61803398...\n\n", .{});
}
