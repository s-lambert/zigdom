const std = @import("std");
const httpz = @import("httpz");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var server = try httpz.Server().init(allocator, .{
        .port = 3000,
    });
    var router = server.router();
    router.get("/", ping);
    return server.listen();
}

fn ping(req: *httpz.Request, res: *httpz.Response) !void {
    _ = req;
    res.body = @embedFile("templ/index.html");
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
