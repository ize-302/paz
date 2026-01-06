const std = @import("std");
const cli_args = @import("cli/args.zig");
const cli_commands = @import("cli/commands.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    // if no argument is provided: run full system upgrade by default
    if (args.len == 1) {
        try cli_commands.handleRunFullSystemUpgrade(stdout);
    } else {
        const first_arg = cli_args.parseArg(args[1]);
        if (first_arg == cli_args.Arg.run_full_system_upgrade) {
            try cli_commands.handleRunFullSystemUpgrade(stdout);
        } else if (first_arg == cli_args.Arg.install_specific_package) {
            try cli_commands.handleInstallPackage(stdout);
        } else if (first_arg == cli_args.Arg.uninstall_specific_package) {
            try cli_commands.handleUninstallPackage(stdout);
        } else if (first_arg == cli_args.Arg.help_menu) {
            try cli_commands.handleHelpCommand(stdout);
        } else if (first_arg == cli_args.Arg.find_installed_package) {
            try cli_commands.handleFindInstalledPackage(stdout);
        } else {
            try std.Io.Writer.print(stdout, "error: no operation specified (use -h for help)", .{});
            try stdout.flush();
        }
    }
}
