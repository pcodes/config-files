# Config Files
My dot files as well as a variety of scripts to manipulate/use them. These work with MacOS and Ubuntu.

### Bootstrapping a new Fedora Installation
Run this one-off command to set up the github CLI + download this repo, all in one-shot.
Maybe eventually this will kick off the config files installer?

```
curl -s https://raw.githubusercontent.com/pcodes/config-files/master/bootstrap_linux.sh | bash
```

### TODO
> ⚠️ WARNING: This is all under construction, everything below this section is super outdated
Next steps:
- Add polybar to this
- Create actual custom polybar
- No more manual lists in the install dotfiles script
- Figure out rofi theme
- Add support for creating .desktop files for things I like (such as obsidian)
- Add support for creating the graphical target for i3 (currently it's in the .bin folder of my laptop)

### ZSH
- `zshrc`: My ZSHRC file. It uses Oh My ZSH as well as a variety of shell plugins for enhanced functionality
- Oh My ZSH Custom Plugins:
  - ZSH Autocomplete
  - ZSH Syntax Highlighting
  - Custom Plugin Autoupdate
  - Powerlevel10k theme
- `install_zsh.sh`: This will download and install Oh my ZSH (ZSH framework), PowerLevel10K (my theme of choice), and the following dependencies:
  - `diff-so-fancy`: Better diff viewing
  - `lsd`: Better `ls` command, uses Nerdfont icons

### Tmux
- `tmux.conf`: Standard tmux.conf file. Will automatically download plugin manager on first install
- Tmux plugins: (coming soon)

### Neovim
I upgraded from Vim 8 to using Neovim. I overhauled my plugin selection and things should be much snappier.
The base file is `neovim.vim` in the `config` directory.
There also is `coc-settings.json` for modifying the `coc` auto-complete plugin.

## Linters + Formatters
- Lua: LuaFormatter
- Bash: Shellcheck + Bashfmt

### Other Scripts
- `update_config.sh`: If you want to update any of the config files, change them in here. Changes are then tracked with VCS, and the script copies the new one.
- `install_vim.sh`: Sets up Vim from my vimrc repo
- `setup_ubuntu`: Script I use for a fresh Ubuntu install
- `scripts/`: Folder with misc shell scripts I use
