const std = @import("std");

const test_targets = [_]std.Target.Query{
    .{
        .cpu_arch = .x86_64,
        .os_tag = .linux,
    },
};

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target_query = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "paz",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target_query,
            .optimize = optimize,
        }),
    });

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_exe.step);

    const test_step = b.step("test", "Run unit tests");

    for (test_targets) |target| {
        const unit_tests = b.addTest(.{
            .root_module = b.createModule(.{
                .root_source_file = b.path("src/main.zig"),
                .target = b.resolveTargetQuery(target),
            }),
        });

        const run_unit_tests = b.addRunArtifact(unit_tests);
        test_step.dependOn(&run_unit_tests.step);
    }
}
