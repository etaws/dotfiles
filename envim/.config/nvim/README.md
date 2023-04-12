# nvim

Neovim 配置文件（for Mac OS and Linux）

## 需要安装的软件

* [glow](https://github.com/charmbracelet/glow)
* [nnn](https://github.com/jarun/nnn)
* [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)
* [stylua](https://github.com/JohnnyMorganz/StyLua)
* ripgrep
* fd
* gnu-sed
* exiftool
* cmake
* llvm
* codelldb

给出一些安装命令的例子（以 Mac OS 为例；在 Linux 下安装对应的版本就行了）：

```shell
brew install glow
brew install nnn
npm install -g markdownlint-cli
brew install ripgrep
brew install gnu-sed
brew install exiftool
cargo install stylua
```

## 需要安装的 LSP Server

* [rust-analyzer](https://rust-analyzer.github.io)
  * 需要格式化代码的话，还需要配置 rustfmt
* [lua-language-server](https://github.com/sumneko/lua-language-server)
  * 需要格式化代码的话，还需要安装 stylua
* cmake-language-server
* clangd
  * 如果要格式化的话，还需要确保能运行 clang-format

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
