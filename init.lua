require("utils.global")

-- 基础配置
require("basic")
-- 快捷键映射
require("keybindings")
-- Packer插件管理
require("plugins")
-- 主题设置
require("colorscheme")
-- 自动命令
require("autocmds")

-- 内置LSP
require("lsp.setup")

-- 自动补全
require("cmp.cmp")

-- 语法高亮
require("plugin-config.nvim-treesitter")
