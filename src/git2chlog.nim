import strutils, strformat

import git2chlogpkg/git

const
  version = """codepoint version 1.0.0
Copyright (c) 2020 jiro4989
Released under the MIT License.
https://github.com/jiro4989/git2chlog"""

proc formatLog(logs: openArray[string], pkg, version, author, email, datetime: string): seq[string] =
  result.add(&"{pkg} ({version}) unstable; urgency=low")
  result.add("")
  for log in logs:
    result.add(&"  * {log}")
  result.add("")
  result.add(&" -- {author} <{email}> {datetime}")
  result.add("")

proc getTagSets(): seq[(string, string)] =
  let tags = getTag()
  for i in 0 ..< tags.len - 1:
    result.add((tags[i], tags[i+1]))

iterator generateDebianChangeLog(pkg, author, email, datetime: string): string =
  let tagSets = getTagSets()
  for tagSet in tagSets:
    let
      startTag = tagSet[0]
      endTag = tagSet[1]
    let lines = getLog(startTag, endTag).formatLog(
      pkg = pkg,
      version = startTag,
      author = author,
      email = email,
      datetime = datetime,
    )
    for line in lines:
      yield line

proc cmdDeb(pkg = "", author = "", email = "", datetime = ""): int =
  discard

when isMainModule and not defined modeTest:
  import cligen
  clCfg.version = version
  dispatchMulti(
    [cmdDeb, cmdName = "deb"],
  )
