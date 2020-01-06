# Config Files
My dot files as well as a variety of scripts to manipulate/use them. These work with MacOS and Ubuntu.

### ZSH
- `zshrc`: My ZSHRC file. It uses Oh My ZSH as well as a variety of shell plugins for enhanced functionality
- `install_zsh.sh`: This will download and install Oh my ZSH (ZSH framework), PowerLevel10K (my theme of choice), and the following dependencies:
  - `diff-so-fancy`: Better diff viewing
  - `lsd`: Better `ls` command, uses Nerdfont icons

### Tmux
- `tmux.conf`: Standard tmux.conf file.
- `install_tmux.sh`: Will install tmux dependencies and copy the tmux.conf file over.
- Tmux plugins: (coming soon)


### Other Scripts
- `update_config.sh`: If you want to update any of the config files, change them in here. Changes are then tracked with VCS, and the script copies the new one.
- `install_vim.sh`: Sets up Vim from my vimrc repo
- `setup_ubuntu`: Script I use for a fresh Ubuntu install
- `scripts/`: Folder with misc shell scripts I use
