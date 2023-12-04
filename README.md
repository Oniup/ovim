# Oniup's Neovim Config

<!--toc:start-->

* [Oniup's Neovim Config](#oniups-neovim-config)
  * [Installation](#installation)
    * [Dependencies](#dependencies)
    * [Instal Neovim Config](#instal-neovim-config)
  * [Uninstall](#uninstall)
* [License](#license)

<!--toc:end-->

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

> You'll need to install [Chocolatey](https://chocolatey.org/)
> which is a windows based package manager. To install the following you'll
> need to open a terminal with administration privileges otherwise windows will
> reject the installation.

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

Once all those packages are installed, COC needs one more package to work,
you'll also need to install pynvim through pip (which installed with python)

```bash
pip install pynvim --upgrade
```

### Instal Neovim Config

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
```

# License

MIT License, which can be found in the [LICENSE](./LICENSE) file
