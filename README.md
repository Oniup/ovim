# Oniup's Neovim Config

## Installation

### Dependencies

Install the following dependencies whatever package manager. 

> If on windows you'll need to install [Chocolatey](https://chocolatey.org/) which 
> is a windows based package manager. To install the following you'll need to type
> into the terminal with administration privileges 

```
choco install [PACKAGE_NAME] -y
```

* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [python](https://community.chocolatey.org/packages/python/3.11.4)
* [cmake](https://cmake.org/)
* [mingw](https://www.mingw-w64.org/)
* [omnisharp](http://www.omnisharp.net/) *NOTE: This is only required for C# development*
* [llvm]() *NOTE: This isn't required, however it is for C/C++ development*
* [vscode-cpptools]() *NOTE: This is only required for C/C++ DAP*
* [node](https://nodejs.org/en) *NOTE: this cannot be installed through chocolatey.
  Also this installed npm with the package*
* [npm](https://www.npmjs.com/)
* [rust](https://www.rust-lang.org/) *NOTE: this will install cargo and rustc
  if through chocolatey*

Once all those pacakges are installed, COC needs one more package to work, you'll 
also need to install pynvim through pip (which installed with python)

```
pip install pynvim --upgrade
```

### Instal Neovim Config

***Windows:***

```
git clone https://github.com/Oniup/neovim-config.git $HOME\AppData\Local\nvim --depth 1
```

***Linux/MacOS:***

```
git clone https://github.com/Oniup/neovim-config.git ~/.config/nvim --depth 1
```

## Uninstall

Delete the following directories to reset Neovim to default

#### Unix

```
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

#### Windows

*NOTE: using powershell or pwsh*

```
Remove-Item ~\AppData\Local\nvim -Recurse -Force
Remove-Item ~\AppData\Local\nvim-data -Recurse -Force
```
