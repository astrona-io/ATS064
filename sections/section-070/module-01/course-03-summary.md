---
draft: true
exam_objectives:
  - State Store
---
# Summary

A state store holds the desired state and must be versioned, immutable and auditable. Git provides this: a commit is a snapshot with a parent, an author, a date and a message, and its SHA is a hash of that content, including the parent's SHA. Rewriting an old commit changes every SHA after it, so the history is tamper-evident as long as the main branch refuses forced updates. Trailers such as `Reviewed-by` attach structured facts to a commit. The store holds intent only. A branch moves, a tag names one fixed commit, and a SHA is exact. Which one the agent follows decides how fast changes arrive and how deliberate each change is. The repository should hold only declared state and no secrets in plain text.

`git log -S<text>` finds the commit where the number of occurrences of a string changed, `git show` reads the commit, and `<sha>^` is its parent. An annotated tag records tagger, date and message, and `git rev-parse <tag>^{commit}` gives the commit SHA that a script needs. To bring the cluster to an older revision without moving the branch, export it with `git archive`, check with `kubectl diff` and apply it. This keeps history intact. `git reset --hard` on a shared branch rewrites history and should be avoided.

- Search the history instead of reading it by hand.
- Name a good revision with an annotated tag.
- Apply an older revision from an export, and leave the branch alone.

<!-- astrona:playground:destroy -->
