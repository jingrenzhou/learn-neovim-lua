local uConfig = require("uConfig")
local uTelescope = uConfig.telescope

if uTelescope == nil or not uTelescope.enable then
  return
end

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

-- local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "normal",
    -- vertical , center , cursor
    layout_strategy = "horizontal",
    -- file_sorter = sorters.get_fzy_sorter,
    -- generic_sorter = sorters.get_fzy_sorter,
    -- 窗口内快捷键
    mappings = {
      -- insert mode
      i = {
        -- move previous/next
        [uTelescope.move_selection_next] = "move_selection_next",
        [uTelescope.move_selection_previous] = "move_selection_previous",
       -- srolling up/down
        [uTelescope.preview_scrolling_up] = "preview_scrolling_up",
        [uTelescope.preview_scrolling_down] = "preview_scrolling_down",
      },
      -- normal mode
      n = {
        [uTelescope.close] = "close",
       -- srolling up/down
        [uTelescope.preview_scrolling_up] = "preview_scrolling_up",
        [uTelescope.preview_scrolling_down] = "preview_scrolling_down",
      },
    },
  },
  pickers = {
    find_files = {
      -- theme = "dropdown", -- 可选参数： dropdown, cursor, ivy
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
        initial_mode = "normal",
      }),
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
})

local opts = {
  noremap = true,
  silent = true,
}
--
local builtin = require('telescope.builtin')
keymap('n', uTelescope.find_files, builtin.find_files, opts)
keymap({'n', 'v'}, uTelescope.grep_string, builtin.grep_string, opts)
keymap('n', uTelescope.recall, builtin.resume, opts)
keymap('n', uTelescope.live_grep, builtin.live_grep, opts)
-- keymap('n', 'fb', builtin.buffers, {})
-- keymap('n', 'fh', builtin.help_tags, {})

-- keymap("n", uTelescope.find_files, ":Telescope find_files<CR>")
-- keymap("n", uTelescope.live_grep, ":Telescope live_grep<CR>")

pcall(telescope.load_extension, "env")
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
pcall(telescope.load_extension, "ui-select")

pcall(telescope.load_extension, "fzf")
