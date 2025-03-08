# Neovim

Neovim 配置文件（for Mac OS and Linux）

## 需要安装的软件

* luajit
* luarocks
* ripgrep
* fd
* gnu-sed
* exiftool

给出一些安装命令的例子（以 Mac OS 为例；在 Linux 下安装对应的版本就行了）：

```shell
brew install luajit
brew install luarocks
brew install ripgrep
brew install gnu-sed
brew install exiftool
```

## 需要用 Mason 插件管理和安装的软件

用 Mason 插件管理和安装的软件主要分 2 类：

### Code Formatter

* [stylua](https://github.com/JohnnyMorganz/StyLua)
* rustfmt
* clang-format

### LSP Server

* [lua-language-server](https://github.com/sumneko/lua-language-server)
* [rust-analyzer](https://rust-analyzer.github.io)
* clangd

> clangd 正常工作，还需要在项目根目录生成一个 compile_commands.json 文件

例如使用 CMake 可以这样生成（先生成 json 文件，再软链接到项目根目录）：

```shell
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B build
ln -s build/compile_commands.json .
```

* 调试代码需要安装 codelldb。安装方案：[参考](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb))
  * dap 插件的配置里面要设置 codelldb 的绝对路径：...codelldb/extension/adapter/codelldb

## 需要安装的字体

* [nerd-fonts](https://www.nerdfonts.com)

