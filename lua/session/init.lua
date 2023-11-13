local M = {}

local utils = require "session.utils"

--- setup plugin with provided options or defaults
---
---@param opts? SessionConfig
function M.setup(opts)
  local config = require "session.config"
  config.set(opts)

  if vim.fn.isdirectory(config.options.dir) == 0 then
    vim.fn.mkdir(config.options.dir, "p")
  end
end

--- load session with given name
---
---@param session string
function M.load(session)
  session = utils.check(session)
  if session then
    M.update()
    utils.hooks("load", function()
      vim.cmd.bufdo {
        args = { "bwipeout" },
        bang = true,
      }
      vim.cmd.source(session)
    end)
  end
end

--- ask to delete session with given name
--- if no name is given uses current session
---
---@param session? string
function M.delete(session)
  if session then
    session = utils.check(session)
  else
    session = utils.current()
  end

  if session then
    vim.ui.select({ "Yes", "No" }, { prompt = ("Delete session %s"):format(session) }, function(choice)
      if choice == "Yes" then
        utils.hooks("delete", function()
          os.remove(session)
        end)
      end
    end)
  end
end

--- create new session
--- prompts user to give a name for the session
function M.new()
  local session
  vim.ui.input({ prompt = "Session name: " }, function(input)
    if input then
      session = input
    end
  end)

  if session and utils.check(session) == nil then
    utils.hooks("save", function()
      vim.cmd.mksession {
        args = { ("%s/%s"):format(require("session.config").options.dir, session) },
      }
    end)
  end
end

--- update session with given name
--- if no name is given uses current session
---
---@param session? string
function M.update(session)
  if session then
    session = utils.check(session)
  else
    session = utils.current()
  end

  if session then
    utils.hooks("save", function()
      vim.cmd.mksession {
        args = { session },
        bang = true,
      }
    end)
  end
end

--- get list of all available sessions
---
---@return string[]
function M.list()
  local sessions = {}

  for file in vim.fs.dir(require("session.config").options.dir) do
    table.insert(sessions, file)
  end

  return sessions
end

return M
