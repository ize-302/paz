const std = @import("std");

const helpMenu =
    \\ Usage:
    \\     paz
    \\     paz <operation> [...]
    \\     paz <package(s)>
    \\
    \\ Pacman operations:
    \\     paz {-h --help}
    \\     paz {-R --remove}      [options] <package>
    \\     paz {-S --sync}        [options] <package>
    \\     paz {-Q --query}       [options] <package>
    \\
    \\ If no arguments are provided 'paz -Syu' will be performed
;

pub fn handleHelpCommand(stdout: *std.Io.Writer) !void {
    try std.Io.Writer.print(stdout, "{s}\n", .{helpMenu});
    try stdout.flush();
}

pub fn handleRunFullSystemUpgrade(stdout: *std.Io.Writer) !void {
    try std.Io.Writer.print(stdout, "Run full system upgrade\n", .{});
    try stdout.flush();
}

pub fn handleInstallPackage(stdout: *std.Io.Writer) !void {
    try std.Io.Writer.print(stdout, "Install package\n", .{});
    try stdout.flush();
}

pub fn handleUninstallPackage(stdout: *std.Io.Writer) !void {
    try std.Io.Writer.print(stdout, "Uninstall package\n", .{});
    try stdout.flush();
}

pub fn handleFindInstalledPackage(stdout: *std.Io.Writer) !void {
    try std.Io.Writer.print(stdout, "Find installed package\n", .{});
    try stdout.flush();
}
