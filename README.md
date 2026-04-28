# Intro
This config is built for Linux systems in mind so installation instructions will only be about Linux as that is the main operating system I work on. However you can still get the configto work but dependencies will be installed differently and I do plan I adding install instructions on other operating systems. 

# Plugins
- nvim-tree
- blink-cmp
- vim-pack
- telescope
- comment
- mason
- autoclose

# Install and Setup for Linux

### Dependencies
This config has some plugins like the lsp and fuzzy finder that require some dependencies to run:
- neovim>=v11.0
- rust tooling 
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
