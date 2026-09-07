# Maintainer Notes

> Repo-management notes for yourself: how to push your own changes, and how to review and merge collaborators' PRs.
> (You can keep this local; if you commit it, note that it's written for the maintainer.)

---

## 1. Pushing my own changes

Even as the repo owner, going through a **branch + PR** is recommended — it keeps `main` clean and leaves a review record. But for small changes when you're working alone, pushing directly to `main` is fine.

### Option A: Push directly to main (small changes / solo work)

```bash
git checkout main
git pull origin main         # pull first to avoid conflicts with remote
git add -A
git status                   # review the list; don't include large files
git commit -m "change description"
git push
```

### Option B: Branch + PR (recommended, especially with collaborators)

```bash
git checkout main
git pull origin main
git checkout -b <branch-name>
git add -A
git commit -m "change description"
git push -u origin <branch-name>
# then open a PR on GitHub, review it yourself, and Merge
```

---

## 2. Reviewing and merging collaborators' PRs

### Simplest: review on the GitHub web UI (recommended)

1. Go to the repo → **Pull requests** tab to see all open PRs;
2. Open a PR;
3. Switch to the **Files changed** tab and review line by line (additions/deletions are highlighted);
4. Comment on a specific line (click the `+` next to the line number) or leave an overall comment below;
5. If satisfied → click **Merge pull request** → **Confirm merge**;
6. After merging, click **Delete branch** to clean up.

> To request changes before merging: leave comments in the PR. The author keeps pushing to the same branch, the PR updates automatically, and you come back to re-review.

### When you need to test locally first (recommended for notebooks)

A diff won't tell you whether a notebook actually runs. To verify by running it yourself:

```bash
git fetch origin                    # fetch info on all remote branches
git checkout <collaborator-branch>  # switch to their branch and run it locally
# ... actually run/verify in JupyterLab ...
```

Once verified, go back to the GitHub web UI and click Merge (recommended — leaves a record).
Or merge locally and push:

```bash
git checkout main
git pull origin main
git merge <collaborator-branch>
git push origin main
```

---

## 3. Handling merge conflicts

If the PR page shows **"This branch has conflicts that must be resolved"**, the branch and `main` changed the same spot. Two ways to resolve:

### Let the collaborator resolve it (recommended)

Ask them to sync the latest main into their branch and resolve the conflict:

```bash
# Collaborator runs:
git checkout <their-branch>
git pull origin main         # conflicts surface here
# manually edit conflicted files (find <<<<<<< ======= >>>>>>> markers, keep the right content)
git add -A
git commit
git push                     # PR updates automatically, conflict cleared
```

### Resolve it locally yourself

```bash
git fetch origin
git checkout <their-branch>
git merge main               # conflicts surface
# manually resolve → git add -A → git commit
git push
# then Merge on the web UI
```

> **Notebook conflicts are especially painful**: `.ipynb` is JSON, and conflicts often corrupt it so it won't open. It's usually easier to decide "keep one whole version" rather than merge line by line:
> ```bash
> git checkout --theirs path/to/notebook.ipynb   # keep their version
> # or --ours to keep the main version
> git add path/to/notebook.ipynb
> ```

---

## 4. Protecting the main branch (optional, recommended)

To force everyone (including yourself) through PRs and forbid direct pushes to `main`:

GitHub repo → **Settings → Branches → Add branch protection rule**:

- **Branch name pattern**: `main`;
- Check **Require a pull request before merging** (forces the PR flow);
- Optionally check **Require approvals** (needs N approvals before merging);
- Save.

Once enabled, any change to `main` must go through a reviewed PR, and `main` can't be pushed to by mistake.

---

## 5. Inviting collaborators

Repo → **Settings → Collaborators → Add people** → enter their GitHub username or email → once they accept, they can clone, branch, and open PRs.

Direct link: `https://github.com/ZhaochenYe999/scrcc_code/settings/access`

---

## Command cheat sheet

| Purpose | Command |
|---|---|
| Pull latest main | `git checkout main && git pull origin main` |
| Fetch all remote branch info | `git fetch origin` |
| Switch to a collaborator's branch to test | `git checkout <branch-name>` |
| Merge a branch locally | `git merge <branch-name>` |
| List all branches (incl. remote) | `git branch -a` |
| View history graphically | `git log --oneline --graph --all` |
| Delete a remote branch | `git push origin --delete <branch-name>` |
