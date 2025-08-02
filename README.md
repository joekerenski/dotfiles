# Arch Linux Dotfiles and Passwords with Chezmoi + Gopass

Secure, reproducible Arch Linux dotfiles using chezmoi for file management and
gopass for encrypted secrets. All this nonsense should enable me to nuke my
system whenever I want (after backing up soem data) and have a completely
functional Arch system again after ~30 min. A man can dream.

## Quick Start

```bash
chezmoi init --apply --verbose https://github.com/joekerenski/dotfiles.git
```

This applies dotfiles including encrypted age identity once.

## Initial Setup (Fresh System)

### 1. Create GitHub Personal Access Token
- Go to GitHub Settings → Developer Settings → Personal Access Tokens → Fine-grained tokens
- Generate token with repository read/write access to your private repo (check
  'Content')

### 2. Set up Gopass with PAT
```bash
gopass init --crypto age
gopass clone https://username:YOUR_PAT@github.com/username/PRIVATE_REPO.git
STORE_NAME
```

### 3. Extract SSH Keys
**Important**: Create SSH archive with relative paths only:
```bash
# On source machine (correct way)
tar czf ssh.tar.gz -C $HOME .ssh
gopass insert --multiline personal/files/ssh  ~/.env
```

### 4. Switch to SSH for GitHub 
Once SSH is working, invalidate the PAT. Then switch your store's remote to your 
ssh url:
```bash
gopass git --store personal remote set-url origin
git@github.com:username/private-repo.git
```

## Common Issues
- **SSH extraction creates nested dirs**: Archive was created with absolute paths. Use `tar czf -C $HOME .ssh`
- **Gopass mount errors**: Use `gopass clone  personal` (sub-store) instead of root store

## Recovery
As long as one machine has gopass configured, you can access all secrets. Store passphrases in gopass itself for recovery: `gopass insert recovery/chezmoi-passphrase`.

## Why?
I don't know. This was a pain to setup. Chezmoi and gopass are janky-ass
software. I WILL write my own simplified version of this after the trauma has
worn off.
