# cd-git-root.yazi

Changes directory to the root of the git repository you are currently in.

## Installation

```sh
ya pkg add ciarandg/cd-git-root
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[[manager.prepend_keymap]]
on   = ["g", "r"]
run  = "plugin cd-git-root"
desc = "Go to git repo root"
```

## License

This plugin is licensed under GPLv3. For more information please check the [LICENSE](LICENSE) file.
