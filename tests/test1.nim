import unittest

include git2chlog

suite "proc formatLog":
  test "normal":
    let want = @[
      "pkg (v1.0.0) unstable; urgency=low",
      "",
      "  * a",
      "  * b",
      "",
      " -- author <email@example.com> 2020-01-01",
      "",
    ]
    let got = ["a", "b"].formatLog("pkg", "v1.0.0", "author", "email@example.com", "2020-01-01")
    check want == got
