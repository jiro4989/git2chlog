import osproc
from sequtils import concat
from strutils import split, strip
from strformat import `&`

const
  logArgs = @["--no-pager", "log"]
  logArgsOneLine = concat(logArgs, @["--max-parents=0"])
  logArgsAuthorName = concat(logArgsOneLine, @["--format=%an"])
  logArgsAuthorEmail = concat(logArgsOneLine, @["--format=%ae"])
  logArgsAuthorDate = concat(logArgs, @["--format=%aD"])
  logArgsFormatLog = concat(logArgs, @["--pretty=format:(%cn) %s"])
  tagArgs = @["--no-pager", "tag", "-l", "--sort=-v:refname"]

proc getAuthorName*(): string =
  result = execProcess("git", args = logArgsAuthorName, options = {poUsePath}).strip

proc getAuthorEmail*(): string =
  result = execProcess("git", args = logArgsAuthorEmail, options = {poUsePath}).strip

proc getAuthorDate*(): string =
  let lines = execProcess("git", args = logArgsAuthorDate, options = {poUsePath}).strip.split("\n")
  if 1 <= lines.len:
    result = lines[0]

proc getAuthorDate*(startTag, endTag: string): string =
  let args = concat(logArgsAuthorDate, @[&"{startTag}..{endTag}"])
  let lines = execProcess("git", args = args, options = {poUsePath}).strip.split("\n")
  if 1 <= lines.len:
    result = lines[0]

proc getLog*(): seq[string] =
  result = execProcess("git", args = logArgsFormatLog, options = {poUsePath}).strip.split("\n")

proc getLog*(startTag, endTag: string): seq[string] =
  let args = concat(logArgsFormatLog, @[&"{startTag}..{endTag}"])
  result = execProcess("git", args = args, options = {poUsePath}).strip.split("\n")

proc getTag*(): seq[string] =
  result = execProcess("git", args = tagArgs, options = {poUsePath}).strip.split("\n")

