import osproc
from strutils import split, strip
from strformat import `&`

proc getAuthorName*(): string =
  let args = ["log", "--format=%an", "--max-parents=0"]
  result = execProcess("git", args = args, options = {poUsePath}).strip

proc getAuthorEmail*(): string =
  let args = ["log", "--format=%ae", "--max-parents=0"]
  result = execProcess("git", args = args, options = {poUsePath}).strip

proc getLog*(startTag, endTag: string): seq[string] =
  let args = ["log", "--pretty=format:(%cn) %s", &"{startTag}..{endTag}"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

proc getTag*(): seq[string] =
  let args = ["git", "tag", "-l", "--sort=-v:refname"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

