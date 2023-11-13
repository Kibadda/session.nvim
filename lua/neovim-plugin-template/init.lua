local M = {}

---@param opts? NeovimPluginTemplateConfig
function M.setup(opts)
  local config = require("neovim-plugin-template.config")
  config.set(opts)
end

return M
