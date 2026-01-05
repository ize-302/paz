const std = @import("std");

pub fn greet() *const [13:0]u8 {
    const value = "Hello, World!";
    return value;
}

pub fn main() !void {
    const value = greet();
    std.debug.print("{s}\n", .{value});
}

test "Should print 'Hello, World!'" {
    try std.testing.expectEqual(greet(), "Hello, World!");
}
