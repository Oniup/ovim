# Ovim

Is a small Neovim configuration setup to make it easy to customize and extend
with your own configurations

## Installation

***Linux:***

Very straight forward, just use your favorite package manager. :)

***MacOS:***

To install the required packages, you'll need Homebrew

```bash
export HOMEBREW_BREW_GIT_REMOTE="..."  # put your Git mirror of Homebrew/brew here
export HOMEBREW_CORE_GIT_REMOTE="..."  # put your Git mirror of Homebrew/homebrew-core here
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

***Windows:***

Install the following dependencies whatever package manager.

> You'll need to install either [Chocolatey](https://chocolatey.org/) or
> [Scoop](https://scoop.sh/) which are terminal based package managers.
> *note: chocolatey requires the terminal to be elevated with admin privileges
> to install anything*

```bash
choco install [PACKAGE_NAME] -y
```

### Dependencies

* [Node](https://nodejs.org/en)
  * *NOTE: this cannot be installed through chocolatey. Node also installs
    npm which is also required*
* [NPM](https://www.npmjs.com/) which a large amount of LSP packages require
  through Mason
* [RipGrep](https://github.com/BurntSushi/ripgrep)
* [Python](https://community.chocolatey.org/packages/python/3.11.4) which
  installs pip. A large amount of LSP packages require pip through Mason
* [CMake](https://cmake.org/)
* [LLVM]()
* [FZF](https://github.com/junegunn/fzf) which is used for fuzzy search to
  improve telescope performance

Make sure that pynvim is installed and is the latest version

```bash
pip install pynvim --upgrade
```

> It is recommended to download and use a Nerd Font for displaying icons. However
> it isn't required.

### Install Ovim

***Windows:***

```
git clone https://github.com/Oniup/neovim-config.git $HOME\AppData\Local\nvim --depth 1
```

***Linux/MacOS:***

```bash
git clone https://github.com/Oniup/neovim-config.git ~/.config/nvim --depth 1
```

## Uninstall

Delete the following directories to reset Neovim to default

***On Linux/MacOS:***

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

***On Windows:***

*NOTE: using powershell or pwsh*

```bash
Remove-Item ~\AppData\Local\nvim -Recurse -Force
Remove-Item ~\AppData\Local\nvim-data -Recurse -Force
Remove-item ~\AppData\Local\Temp\nvim -Recurse -Force
```

# License

MIT License, which can be found in the [LICENSE](./LICENSE) file
