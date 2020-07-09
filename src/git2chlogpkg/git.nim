import osproc
from strutils import split, strip
from strformat import `&`

proc getAuthorName*(): string =
  let args = ["--no-pager", "log", "--format=%an", "--max-parents=0"]
  result = execProcess("git", args = args, options = {poUsePath}).strip

proc getAuthorEmail*(): string =
  let args = ["--no-pager", "log", "--format=%ae", "--max-parents=0"]
  result = execProcess("git", args = args, options = {poUsePath}).strip

proc getLog*(tag1, tag2: string): seq[string] =
  let args = ["--no-pager", "log", "--pretty=format:(%cn) %s", &"{tag1}..{tag2}"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

proc getTag*(): seq[string] =
  let args = ["--no-pager", "tag", "-l", "--sort=-v:refname"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

