
##### Checks if any of your python dependencies need updating

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

## ⇁ TOC
* [Problem Statement](#-Problem-Statement)
* [Solution](#-Solution)
* [Installation](#-Installation)
* [Usage](#-Usage)

## ⇁ Problem Statement
If you work on a project with multiple dependencies installed, you should be able to easily determine if any of them need to be updated (or may be updated). 

## ⇁ Solution
A plugin that allows you to check libraries installed in your virtual environment and determines if there are newer versions of them available in the [PyPi repository](https://pypi.org/). 

Nowadays libraries are dependent on other libraries and following what changes in all of the dependencies tree is difficult if not impossible. That is why I created a plugin that checks only high-level dependencies (the ones listed in the `requirements.in` file)

## ⇁ Installation
* neovim 0.8.0+ required
* install using your favorite plugin manager (i am using `packer` in this case)
```lua
use "okonmarcin/req-check.nvim"
```
* install using [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "okonmarcin/req-check.nvim",
}
```

## ⇁ Usage
### Prerequisites ###
All operations listed below need to be performed while your `requirements.in` file is opened.

### `:ReqCheck` ###
Command will check wchich dependecies can potentially be updated. Result will show on the screen after few seconds as a virtual text near dependency that has a newer version in the PyPi.

<div align="center">
<img alt="Result" height="280" src="/assets/example_result.png" />
</div>

### `:ReqUpdate` ###
Command will recompile `*.in` file into `*.txt` file with newer versions if that's possible. (It may not happen if a library is dependent on a particular version of other library from the `*.in` file.)

### `:ReqInstall` ###
Command will reinstall all dependencies listed in `*.txt` file. After invoking this one can run again `:ReqCheck` to see if the state of the installed libraries has changed.

