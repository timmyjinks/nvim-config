# Intro
This config is built for Linux systems in mind so installation instructions will only be about Linux as that is the main operating system I work on. However you can still get the config to work but dependencies will be installed differently and I do plan I adding install instructions on other operating systems. 

# Plugins
- nvim-tree
- nvim-cmp
- lazygit
- lazyvim
- telescope
- comment
- mason
- mason-lspconfig

# Install and Setup for Linux

### Dependencies
This config has some plugins like the lsp and fuzzy finder that require some dependencies to run. You can go ![here]() to 
- cargo
- neovim>=v10.0
- python3
- npm
- make
- gcc
- ripgrep
  
```
git clone https://github.com/timmyjinks/nvim-config.git
```
You can install the dependencies by runing the install.sh script
```
chmod +x install.sh
sh install.sh
```

You want to find the nvim config file location, on most Linux systems it will be located in $HOME/.config/nvim.
Your going to take the contents of the config directory you are in and paste it into the nvim directory
```
cp -r . $HOME/.config/
mv $HOME/.config/nvim-config nvim
```

# Demo
### Home Screen
![image](https://github.com/user-attachments/assets/f39ba6f4-40f7-4a2a-8ec6-0f1f9c49a623)

### File Tree
![image](https://github.com/user-attachments/assets/ee1c03b6-8f0a-46ac-b3d1-9af12e9cb028)

### Fuzzy Finder
![image](https://github.com/user-attachments/assets/96546362-4a6b-4e95-8d64-44121644ffa5)

### Auto Completion
![image](https://github.com/user-attachments/assets/0ff75bf9-ebd5-48ee-a3c7-60e74285f038)


# Shortcuts
These are the shortcuts used to access the features of the plugins. The \<leader\> key is the space key.
|Shortcut|Description|
|--------|----------|
|\<leader\>es|Switch between file explorer|
|\<leader\>ee|Toggle File Explorer|
|\<leader\>ef|Toggle current file explorer|
|\<leader\>ec|Collapse file explorer|
|\<leader\>er|Refresh file explorer|
|\<leader\>ff|Fuzzy find fiels in cw|
|\<leader\>fr|Fuzzy find recent files|
|\<leader\>fs|Find string in cwd|
|\<leader\>fc|Find string under cursor in cwd|
|\<leader\>gcc|Comment entire line|
|\<leader\>mp|Activate Formatter|

