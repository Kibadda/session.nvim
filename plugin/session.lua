if vim.g.loaded_session then
  return
end

vim.g.loaded_session = 1

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("SessionNvim", { clear = true }),
  callback = function()
    local session = require "session"
    if session.config().save_on_exit then
      session.update()
    end
  end,
})

vim.keymap.set("n", "<Plug>(SessionNew)", function()
  require("session").new()
end)
vim.keymap.set("n", "<Plug>(SessionUpdate)", function()
  require("session").update()
end)
vim.keymap.set("n", "<Plug>(SessionLoad)", function()
  require("session").load()
end)
vim.keymap.set("n", "<Plug>(SessionDelete)", function()
  require("session").delete()
end)
