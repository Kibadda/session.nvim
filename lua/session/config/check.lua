local M = {}

---@param path string
---@param tbl table
---@return boolean
---@return string?
local function validate(path, tbl)
  local prefix = "invalid config: "
  local ok, err = pcall(vim.validate, tbl)
  return ok or false, prefix .. (err and path .. "." .. err or path)
end

---@param config session.Config
---@return boolean
---@return string?
function M.validate(config)
  local ok, err

  ok, err = validate("session", {
    dir = { config.dir, "string", true },
    save_on_exit = { config.save_on_exit, "boolean", true },
  })
  if not ok then
    return false, err
  end

  return true
end

return M
