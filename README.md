
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

* Check
Usage of the plugin is pretty straightforward, just type `:ReqCheck` command while your current buffer shows the `*.in` file that lists your high-level dependencies, after a couple of seconds you'll see a virtual text near the libraries that can potentially be updated.
The result presented on the screenshot below:

<div align="center">
<img alt="Result" height="280" src="/assets/example_result.png" />
</div>

* Update
To recompile `requirements.in` file use command `:ReqUpdate`, it will generate updated `requirements.txt` file in the same directory as `requirements.in` is in.

* Install
To reinstall requirements file use command `:ReqInstall`, it will invoke `pip install... ` command undernith and all dependencies will be reinstalled accorgind to `requirements.txt` file content.

