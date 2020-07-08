import osproc
from strutils import split
from strformat import `&`

proc getAuthorName*(): string =
  discard

proc getAuthorEmail*(): string =
  discard

proc getLog*(startTag, endTag: string): seq[string] =
  let args = ["log", "--pretty=format:(%cn) %s", &"{startTag}..{endTag}"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

proc getTag*(): seq[string] =
  let args = ["git", "tag", "-l", "--sort=-v:refname"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

