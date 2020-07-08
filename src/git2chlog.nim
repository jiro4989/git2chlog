import osproc, strutils, strformat

proc getLogs(startTag, endTag: string): seq[string] =
  let args = ["log", "--pretty=format:(%cn) %s", &"{startTag}..{endTag}"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

proc formatLog(logs: seq[string], pkg, version, author, email, datetime: string): seq[string] =
  result.add(&"{pkg} ({version}) unstable; urgency=low")
  result.add("")
  for log in logs:
    result.add(&"  * {log}")
  result.add("")
  result.add(&" -- {author} <{email}> {datetime}")
  result.add("")

proc getTags(): seq[string] =
  let args = ["git", "tag", "-l", "--sort=-v:refname"]
  result = execProcess("git", args = args, options = {poUsePath}).split("\n")

proc getTagSets(): seq[(string, string)] =
  let tags = getTags()
  for i in 0 ..< tags.len - 1:
    result.add((tags[i], tags[i+1]))

iterator generateDebianChangeLog(pkg, version, author, email, datetime: string): string =
  let tagSets = getTagSets()
  for tagSet in tagSets:
    let lines = getLogs(tagSet[0], tagSet[1]).formatLog(
      pkg = pkg,
      version = version,
      author = author,
      email = email,
      datetime = datetime,
    )
    for line in lines:
      yield line

when isMainModule and not defined modeTest:
  discard
