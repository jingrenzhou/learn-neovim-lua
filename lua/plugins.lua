-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end

packer.startup({
  function(use)
    -- Packer 可以升级自己
    use("wbthomason/packer.nvim")
    -------------------------- plugins -------------------------------------------
    -- use("lewis6991/impatient.nvim")
    -- use("nathom/filetype.nvim")

    -- nvim-tree
    use({
      "nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("plugin-config.nvim-tree")
      end,
    })

    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
      config = function()
        require("plugin-config.bufferline")
      end,
    })

    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("plugin-config.lualine")
      end,
    })

    -- treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    })

    -- telescope-fzf
    use ({'nvim-telescope/telescope-fzf-native.nvim',
     run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    })

    -- telescope
    use({
      "nvim-telescope/telescope.nvim", tag = '0.1.0',
      -- opt = true,
      -- cmd = "Telescope",
      requires = {
        -- telescope extensions
        { "nvim-lua/plenary.nvim" },
        { "LinArcX/telescope-env.nvim" },
    --    { "nvim-telescope/telescope-fzf-native.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      config = function()
        require("plugin-config.telescope")
      end,
    })

    -- symbol-outline (similar to tarbar)
    use ({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("plugin-config.symbols-outline")
      end,
    })


    -- Comment
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugin-config.comment")
      end,
    })

    -- nvim-notify
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("plugin-config.nvim-notify")
      end,
    })

    -- todo-comments.nvim
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugin-config.todo-comments")
      end,
    })

    --------------------- LSP --------------------
	use({
    	-- Lspconfig
		"neovim/nvim-lspconfig",
		requires = {
			-- lspconfig extensions
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		}
	})

      -- 补全引擎    
    use("hrsh7th/nvim-cmp")
    -- Snippet 引擎    
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- 补全源    
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }    
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },    
    use("hrsh7th/cmp-path") -- { name = 'path' }    
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }    
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
    use("hrsh7th/cmp-nvim-lua") -- A nvim-cmp source for the Neovim Lua API.
    use("lukas-reineke/cmp-rg") -- A nvim-cmp source for Ripgrep.
    use({
      "petertriho/cmp-git",
      requires = "nvim-lua/plenary.nvim"
    }) -- A nvim-cmp source for Git.

    -- UI 增强                                                                                                                             
    use("onsails/lspkind-nvim")
    -- Lua 增强
    use({"folke/neodev.nvim"})
	-- go 增强
	use({
		"ray-x/go.nvim",
		requires = "ray-x/guihua.lua",
		config = function()
			require("plugin-config.gonvim")
		end,
	} )

    --------------------- colorschemes --------------------
    -- tokyonight
    use({ "folke/tokyonight.nvim" })

    -- OceanicNext
    -- use({ "mhartington/oceanic-next", event = "VimEnter" })

    -- gruvbox
    -- use({
    --   "ellisonleao/gruvbox.nvim",
    --   requires = { "rktjmp/lush.nvim" },
    -- })

    -- zephyr
    -- use("glepnir/zephyr-nvim")

    -- nord
    -- use("shaunsingh/nord.nvim")

    -- onedark
    -- use("ful1e5/onedark.nvim")

    -- nightfox
    -- use("EdenEast/nightfox.nvim")

    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    -- 锁定插件版本在snapshots目录
    -- snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- 这里锁定插件版本在v1，不会继续更新插件
    -- snapshot = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots") .. "/v1",
    --snapshot = "v1",

    -- 最大并发数
    max_jobs = 32,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    -- display = {
    -- 使用浮动窗口显示
    --   open_fn = function()
    --     return require("packer.util").float({ border = "single" })
    --   end,
    -- },
  },
})
