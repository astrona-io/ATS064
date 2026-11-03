---
draft: true
exam_objectives:
  - State Store
---
# Finding And Marking A Revision

When a delivery goes wrong, two questions come first: which commit introduced the problem, and which revision was the last good one. This part shows how to answer both with Git, how to mark the good revision so it can be named later, and how to apply that revision to the cluster without erasing any history.

## Find the commit that introduced a change

A search through every file by hand does not scale. Git can search the history for the commit where a string appeared or disappeared. The option is `-S`, called the pickaxe. `git log -S<text>` lists the commits that changed the number of occurrences of that text.

```sh
git log -S"EXPERIMENTAL_MODE" --format='%H %an %s'
```

The command prints the full SHA, the author and the subject of each matching commit. When the text was added once and never removed, exactly one commit matches, and that commit is the one that introduced it. `--reverse` lists the oldest first. If the text was added and later removed, two commits match: the one that added it and the one that removed it.

A related option, `-G<regex>`, matches commits whose diff has a line that fits a pattern, even when the count of occurrences did not change. `git blame <file>` goes the other way: it shows, for each line of a file, the commit that last changed it.

## Look at the commit

Before blaming a commit, read it:

```sh
git show <sha>
```

The output shows the message and the diff. The diff tells you what the change did. The message tells you why. Compare the two, because a mismatch between them is often the real finding.

## Identify the last good revision

The parent of the bad commit is the state just before the problem. Git writes it as `<sha>^`, for example `git rev-parse <sha>^`, which prints the full SHA of the parent. A merge commit has more than one parent, and `^1` names the first. Use the full SHA when you record a revision in a file, because short SHAs can become ambiguous as a repository grows.

## Mark it with an annotated tag

A **tag** is a name for a commit. There are two kinds. A lightweight tag is only a name. An **annotated tag** is an object of its own with a tagger, a date and a message, so it records who marked the revision and why. Use annotated tags for releases:

```sh
git tag -a release-1 <good-sha> -m "Last revision before EXPERIMENTAL_MODE"
git cat-file -t release-1
git rev-parse release-1^{commit}
```

`git cat-file -t` prints `tag` for an annotated tag and `commit` for a lightweight one. `release-1^{commit}` follows the tag to the commit it names, and `git rev-parse release-1` alone prints the SHA of the tag object, which is a different value. When a file must hold the commit SHA, use the form with `^{commit}`.

A tag does not move on its own. A tag is shared with a remote only when you push it. Teams often protect tags in the same way they protect branches, so that a release name cannot be pointed at other content.

## Bring the cluster to that revision

Marking a revision does not change the cluster. The agent, which is you in this course, applies the files of that revision. Export the revision's files into a temporary directory instead of checking the revision out, so your working tree stays on the branch:

<!-- astrona:playground:renew -->

```sh
cd ~/gitops-lab/play-070
WORK="$(mktemp -d)"
git archive release-1 apps | tar -x -C "$WORK"
kubectl diff -R -f "$WORK/apps"
kubectl apply -R -f "$WORK/apps"
```

`git archive` writes the files of a revision as an archive, and `tar -x` unpacks them. `kubectl diff` shows what the apply would change, and it exits with 0 when nothing would change, 1 when there are differences, and a higher value on an error. `kubectl apply` then makes the cluster match. Fields that an earlier apply set and that the old revision does not set are removed, because `kubectl apply` remembers what it applied last time.

Applying an older revision does not alter the repository. The branch still points to the newest commit, and the bad commit is still in the history. This matters for two reasons. The record of what happened stays intact. And the next apply from the branch would bring the problem back, unless the problem is also fixed in a new commit or the agent is pointed at the tag.

## Why not reset the branch

`git reset --hard <sha>` moves a branch back and drops the later commits from it. On a branch that others read, this rewrites history. People who already fetched the later commits now disagree with the store, and the audit trail has a gap. A tag and a new commit leave everyone's view consistent. If the branch must return to an earlier state, the safe method is a new commit that undoes the change, which keeps the old commits in place.

## Record what you found

Write the result where others can read it. The tag and its message are one place. A small file in the repository, such as `released.txt` holding the full SHA, is another and can be read by scripts. Keep the file in Git so the record has history too.

```sh
git rev-parse release-1^{commit} > released.txt
git add released.txt
git commit -m "Record the release revision"
```

## Reading a diff between two tags

Once two tags exist, the difference between them is a precise statement of what a release changed:

```sh
git diff release-1 release-2 --stat -- apps
git log release-1..release-2 --format='%h %an %s'
```

The first command lists the files that differ. The second lists the commits that are in `release-2` and not in `release-1`. The two-dot form `A..B` means "reachable from B and not from A". These are the same questions an agent answers when it moves from one revision to another, and they let a reviewer see the scope of a promotion before it happens.

## Common pitfalls

> [!WARNING]
> Do not use `git reset --hard` on a branch that other people or an agent read. Do not record a short SHA when a script needs an exact one, and do not confuse the SHA of an annotated tag with the SHA of the commit it names. Check with `kubectl diff` before you apply an older revision, and remember that the branch still holds the newer commits.
