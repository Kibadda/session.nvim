local M = {}

--- validate given config
---@param config session.internalconfig
---@return boolean
---@return string[]
function M.validate(config)
  local errors = {}

  --- small wrapper around vim.validate
  ---@param name string
  ---@param value any
  ---@param types any|any[]
  ---@param optional? boolean
  ---@return boolean
  local function validate(name, value, types, optional)
    local ok, err = pcall(vim.validate, name, value, types, optional)

    if not ok then
      table.insert(errors, err)
    end

    return ok
  end

  validate("session.dir", config.dir, "string", true)
  validate("session.save_on_exit", config.save_on_exit, "boolean", true)

  return #errors == 0, errors
end

return M
