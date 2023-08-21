# Simple Neovim Config

## Installation

### Dependencies

Install the following dependencies whatever package manager. 

> If on windows you'll need to install [Chololatey](https://chocolatey.org/) which 
> is a windows based package manager. To install the following you'll need to type
> into the terminal with administration privileges 

```
choco install [PACKAGE_NAME] --force -y
```

* [fzf](https://github.com/junegunn/fzf)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [python]()
* [cmake]()
* [mingw]()
* [llvm]() *NOTE: This isn't required, however it is for C/C++ development*
* [node](https://nodejs.org/en) *NOTE: this cannot be installed through chocolatey. 
  Also this installed npm with the package*
* [npm](https://www.npmjs.com/)

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

### Instal Packer

***Windows:***

```
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```

## Example COC settings

```json
{
	"suggest.noselect": true,
	"inlayHint.enable": false,

	"clangd.path": "C:\\Program Files\\LLVM\\bin\\clangd.exe",
	"clangd.compilationDatabasePath": ".\\bin",
	"semanticTokens.enable": true
}
```

