import os, times, strutils, strformat

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

iterator generateDebianChangeLog(pkg, author, email: string): string =
  let tagSets = getTagSets()
  for tagSet in tagSets:
    let
      endTag = tagSet[0]
      startTag = tagSet[1]
    let lines = getLog(startTag, endTag).formatLog(
      pkg = pkg,
      version = startTag,
      author = author,
      email = email,
      datetime = git.getAuthorDate(startTag, endTag),
    )
    for line in lines:
      yield line

proc cmdDeb(pkg = "", author = "", email = "", outFile = ""): int =
  let
    pkg =
      if pkg == "": getCurrentDir().splitPath.tail
      else: pkg
    author =
      if author == "": git.getAuthorName()
      else: author
    email =
      if email == "": git.getAuthorEmail()
      else: email

  var file =
    if outFile == "": stdout
    else: open(outFile, fmRead)
  defer:
    file.close()

  for line in generateDebianChangeLog(pkg, author, email):
    file.writeLine(line)

when isMainModule and not defined modeTest:
  import cligen
  clCfg.version = version
  dispatchMulti(
    [cmdDeb, cmdName = "deb"],
  )
