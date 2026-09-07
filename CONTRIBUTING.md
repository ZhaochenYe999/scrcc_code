# Contributing Guide

This repository uses a **branch + Pull Request (PR)** workflow. Please **do not push directly to `main`** — all changes go through your own branch and get merged into `main` only after review. This keeps `main` clean and always in a working state.

---

## 1. First-time setup (once per person)

### 1. Set up an SSH key (recommended — no password prompts)

```bash
# Check whether you already have a key
ls ~/.ssh/id_ed25519.pub 2>/dev/null || ls ~/.ssh/id_rsa.pub 2>/dev/null

# If not, generate one (use your GitHub email)
ssh-keygen -t ed25519 -C "your_email@example.com"
# Press Enter through the prompts; passphrase can be left empty

# Print your public key and copy the whole output
cat ~/.ssh/id_ed25519.pub
```

Paste the output into GitHub → **Settings → SSH and GPG keys → New SSH key** → save.

Verify:

```bash
ssh -T git@github.com
# "Hi <your-username>! You've successfully authenticated" means success
```

### 2. Set your git identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

### 3. Clone the repository

```bash
git clone git@github.com:ZhaochenYe999/scrcc_code.git
cd scrcc_code
```

---

## 2. Day-to-day contribution workflow

### Step 1: Create a new branch from the latest main

**Start a new branch for each new task** — don't pile unrelated changes onto an old branch.

```bash
git checkout main            # switch to main
git pull origin main         # update to latest (important: branch off current code)
git checkout -b <branch-name>  # create and switch to the new branch
```

Name the branch after its purpose, e.g. `fix-clustering`, `add-deg-analysis`, `zhang-qc-notebook`.

### Step 2: Make changes, then commit

```bash
git add -A                   # stage all changes (.gitignore entries are skipped automatically)
git status                   # review the list before committing — don't include large data files
git commit -m "short description of the change"
```

You can edit and commit multiple times; they all accumulate on this branch.

### Step 3: Push the branch to GitHub

```bash
git push -u origin <branch-name>   # first push of this branch
# afterwards, just `git push` for the same branch
```

### Step 4: Open a Pull Request

After pushing, the terminal prints a GitHub link you can open to start a PR. Or go to the repo on GitHub, where a **"Compare & pull request"** button appears automatically:

1. Click that button;
2. Fill in a title and description (what changed and why);
3. Click **Create pull request**.

Then wait for the maintainer to review. If changes are requested, just keep committing and pushing to the **same branch** — the PR updates automatically, no need to open a new one.

---

## 3. After a merge: sync the latest main

Once your PR (or someone else's) is merged, your local `main` is out of date. Update it before starting a new branch:

```bash
git checkout main
git pull origin main

# Clean up merged branches you no longer need (optional)
git branch -d <branch-name>                    # delete local branch
git push origin --delete <branch-name>         # delete branch on GitHub
```

---

## 4. Important conventions

### Jupyter Notebooks: clear outputs before committing

`.ipynb` files store **code and cell outputs (images, large dataframes) together as JSON**, which bloats files, makes diffs unreadable, and **causes hard-to-resolve merge conflicts**. **Clear outputs before committing:**

```bash
# Clear a single file
jupyter nbconvert --clear-output --inplace your_notebook.ipynb

# Recursively clear all notebooks (excluding checkpoints)
find . -name "*.ipynb" -not -path "*/.ipynb_checkpoints/*" \
  -exec jupyter nbconvert --clear-output --inplace {} +
```

### Avoid editing the same notebook simultaneously

Notebook merge conflicts often corrupt the JSON and make the file unopenable. Please agree that **each person owns different notebooks**; when collaboration is unavoidable, coordinate and stagger your edits.

### Don't commit large data files

`.h5ad`, `.rds`, intermediate CSVs, etc. are already excluded in `.gitignore`. Please don't force-add them — GitHub's per-file limit is 100 MB, and they slow down the whole repo. Keep large data in a shared cluster directory and point to it via relative paths / config in your code.

### If main moved while you were on your branch

If `main` was updated by someone else's PR while you were working, sync the new main into your branch before merging to reduce conflicts:

```bash
git checkout <branch-name>
git pull origin main         # merge latest main into your branch
# if there are conflicts, resolve them, then git add + git commit
git push
```

---

## Command cheat sheet

| Purpose | Command |
|---|---|
| Check current branch and change status | `git status` |
| List local branches | `git branch` |
| Switch branch | `git checkout <branch-name>` |
| Create and switch to a new branch | `git checkout -b <branch-name>` |
| Stage all changes | `git add -A` |
| Commit | `git commit -m "message"` |
| Push current branch | `git push` |
| View history graphically | `git log --oneline --graph --all` |

---

**One-line flow:** `git checkout main && git pull` → `git checkout -b new-branch` → edit → `git add -A && git commit -m "..."` → `git push -u origin new-branch` → open PR on the web → wait for review and merge.
