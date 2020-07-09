import osproc
from strutils import split, strip
from strformat import `&`

proc getAuthorName*(): string =
  let args = ["--no-pager", "log", "--format=%an", "--max-parents=0"]
  result = execProcess("git", args = args, options = {poUsePath}).strip

proc getAuthorEmail*(): string =
  let args = ["--no-pager", "log", "--format=%ae", "--max-parents=0"]
  result = execProcess("git", args = args, options = {poUsePath}).strip

proc getAuthorDate*(startTag, endTag: string): string =
  let args = ["--no-pager", "log", "--format=%aD", &"{startTag}..{endTag}"]
  let lines = execProcess("git", args = args, options = {poUsePath}).strip.split("\n")
  if 1 <= lines.len:
    result = lines[0]

proc getLog*(startTag, endTag: string): seq[string] =
  let args = ["--no-pager", "log", "--pretty=format:(%cn) %s", &"{startTag}..{endTag}"]
  result = execProcess("git", args = args, options = {poUsePath}).strip.split("\n")

proc getTag*(): seq[string] =
  let args = ["--no-pager", "tag", "-l", "--sort=-v:refname"]
  result = execProcess("git", args = args, options = {poUsePath}).strip.split("\n")

