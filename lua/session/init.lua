local M = {}

---@param session string
local function save(session)
  local config = require("session.config").get()

  if vim.fn.isdirectory(config.dir) == 0 then
    vim.fn.mkdir(config.dir, "p")
  end

  vim.cmd.mksession {
    args = { session },
    bang = true,
  }
end

--- create new session
function M.new()
  local session

  vim.ui.input({ prompt = "Session name: " }, function(input)
    session = input
  end)

  if not session or session == "" then
    return
  end

  local config = require("session.config").get()

  if vim.fn.filereadable(config.dir .. "/" .. session) == 1 then
    vim.notify("session: a session with name '" .. session .. "' already exists.", vim.log.levels.ERROR)
    return
  end

  save(config.dir .. "/" .. session)
end

--- update current session
function M.update()
  if vim.v.this_session == nil or vim.v.this_session == "" or vim.fn.filereadable(vim.v.this_session) == 0 then
    vim.notify("session: currently not in a session", vim.log.levels.WARN)
    return
  end

  save(vim.v.this_session)
end

--- get a list of sessions in `vim.g.session.dir`
---@return string[]
function M.list()
  local config = require("session.config").get()
  local sessions = {}

  for name in vim.fs.dir(config.dir) do
    table.insert(sessions, name)
  end

  table.sort(sessions)

  return sessions
end

--- load given session or session selected via `vim.ui.select`
--- updates current session before loading
---@param session string?
function M.load(session)
  if not session then
    vim.ui.select(M.list(), { prompt = "Session" }, function(choice)
      session = choice
    end)
  end

  local config = require("session.config").get()

  if not session or session == "" or vim.fn.filereadable(config.dir .. "/" .. session) == 0 then
    vim.notify("session: could not find session '" .. (session or "") .. "'", vim.log.levels.WARN)
    return
  end

  if vim.v.this_session ~= nil and vim.v.this_session ~= "" then
    M.update()
  end

  vim.cmd "silent! %bwipeout"
  vim.cmd.source(config.dir .. "/" .. session)
end

--- delete current session
function M.delete()
  if vim.v.this_session == nil or vim.v.this_session == "" or vim.fn.filereadable(vim.v.this_session) == 0 then
    vim.notify("session: currently not in a session", vim.log.levels.WARN)
    return
  end

  if vim.fn.confirm("Delete current session?", "&Yes\n&No", 2) == 1 then
    os.remove(vim.v.this_session)
  end
end

return M
