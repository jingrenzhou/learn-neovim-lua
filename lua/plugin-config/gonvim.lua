local status, go = pcall(require, "go")
if not status then
  vim.notify("没有找到 go.nvim")
  return
end

go.setup()

vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
