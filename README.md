# how to

先安装 stow. 例如在 Mac 上用 brew 安装:

```shell
brew install stow
```

然后建立以下目录, nvim 的所有配置在 `.dotfiles/envim/.config/nvim` 目录下:

```shell
.dotfiles
└────envim
        └── .config
         └── nvim
```

最后运行 stow 命令:

```shell
brew install stow
stow envim
```

把 `.dotfiles/envim/.config/nvim` 链接为 `.config/nvim`
