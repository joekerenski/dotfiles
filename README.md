# Setup from scratch on a _virgin_ system (arch btw)

Make sure gopass, chezmoi, age and git are installed.
The gopass templates will error out at first,
then work after gopass has been set up.

1. Run chezmoi

```console
chezmoi init --apply --verbose git@github.com:kerenski/dotfiles.git
```

2. Run gopass

Without ssh:

```console
gopass clone https://username:<pat-token>@github.com/username/<private-repo-name>.git --crypto=age
```

With ssh:

```console
gopass clone git@github.com:<username>/<private-repo-name>.git --crypto=age
```

Rerun chezmoi to populate templates:

```console
chezmoi apply
```

And we are done.
