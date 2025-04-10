vim.g.have_nerd_font = true

-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- 是否开启高亮搜索
vim.o.hlsearch = true

vim.wo.number = true

vim.o.breakindent = true

-- 高亮所在行
vim.wo.cursorline = true

-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"

-- 右侧参考线，超过表示代码太长了，考虑换行
vim.wo.colorcolumn = "80"

-- 是否开启自动缩进
vim.o.autoindent = true
-- 设定自动缩进的策略为 plugin
vim.o.filetype = "plugin"
-- 缩进 4 个空格等于一个Tab
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true

-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 禁止折行
vim.wo.wrap = false
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- smaller updatetime
vim.o.updatetime = 100
vim.wo.signcolumn = "yes"
-- 设置 timeoutlen 为等待键盘快捷键连击时间 100 毫秒，可根据需要设置
-- 遇到问题详见：https://github.com/nshen/learn-neovim-lua/issues/1
vim.o.timeoutlen = 100

-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true

-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = true
vim.o.listchars = "eol:^,space:.,tab:<->,trail:~,extends:>,precedes:<"

-- 命令行高为2，提供足够的显示空间
vim.o.cmdheight = 2
-- 永远显示 tabline
vim.o.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode = false
