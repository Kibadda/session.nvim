local M = {}

--- check if session with given name exists
---
---@param session? string
function M.check(session)
  return vim.fs.find(session or "", {
    path = require("session.config").options.dir,
  })[1]
end

--- get current session name
---
---@return string?
function M.current()
  return #vim.v.this_session > 0 and vim.v.this_session or nil
end

--- apply given callback with hooks defined in config
---
---@param action "save"|"delete"|"load"
---@param callback function
function M.hooks(action, callback)
  local config = require "session.config"

  if type(config.options.hooks.pre[action]) == "function" then
    config.options.hooks.pre[action]()
  end

  callback()

  if type(config.options.hooks.post[action]) == "function" then
    config.options.hooks.post[action]()
  end
end

return M
