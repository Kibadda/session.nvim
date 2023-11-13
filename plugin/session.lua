if vim.g.loaded_session == 1 then
  return
end

vim.g.loaded_session = 1

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("SessionVimLeaveSaveSession", { clear = true }),
  callback = function()
    if require("session.config").options.save_on_vim_leave then
      require("session").update()
    end
  end,
})
