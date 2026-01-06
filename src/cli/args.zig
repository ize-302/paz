const std = @import("std");

pub const Arg = enum(u8) { install_specific_package, run_full_system_upgrade, uninstall_specific_package, find_installed_package, help_menu };

pub fn parseArg(arg: []const u8) ?Arg {
    if (std.mem.eql(u8, arg, "-S") or std.mem.eql(u8, arg, "--sync")) {
        return .install_specific_package;
    } else if (std.mem.eql(u8, arg, "-R") or std.mem.eql(u8, arg, "--remove")) {
        return .uninstall_specific_package;
    } else if (std.mem.eql(u8, arg, "-Syu")) {
        return .run_full_system_upgrade;
    } else if (std.mem.eql(u8, arg, "-Q") or std.mem.eql(u8, arg, "--query")) {
        return .find_installed_package;
    } else if (std.mem.eql(u8, arg, "--help") or std.mem.eql(u8, arg, "-h")) {
        return .help_menu;
    }
    return null;
}
