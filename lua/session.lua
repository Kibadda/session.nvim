local M = {}

---@class SessionConfig
---@field dir string path to session directory
---@field save_on_exit boolean wether session should be saved on VimLeave

---@return SessionConfig
function M.config()
  return vim.tbl_deep_extend("force", {}, {
    dir = vim.fn.stdpath "data" .. "/session",
    save_on_exit = true,
  }, vim.g.session or {})
end

---@param session string
local function save(session)
  local config = M.config()

  if vim.fn.isdirectory(config.dir) == 0 then
    vim.fn.mkdir(config.dir, "p")
  end

  pcall(vim.cmd.argdelete, "*")

  vim.cmd.mksession {
    args = { session },
    bang = true,
  }
end

function M.new()
  local session

  vim.ui.input({ prompt = "Session name: " }, function(input)
    session = input
  end)

  if not session or session == "" then
    return
  end

  local config = M.config()

  if vim.fn.filereadable(config.dir .. "/" .. session) == 1 then
    vim.notify("session: a session with name '" .. session .. "' already exists.", vim.log.levels.ERROR)
    return
  end

  save(config.dir .. "/" .. session)
end

function M.update()
  if vim.v.this_session == nil or vim.v.this_session == "" or vim.fn.filereadable(vim.v.this_session) == 0 then
    vim.notify("session: currently not in a session", vim.log.levels.WARN)
    return
  end

  save(vim.v.this_session)
end

---@return string[]
function M.list()
  local config = M.config()
  local sessions = {}

  for name in vim.fs.dir(config.dir) do
    table.insert(sessions, name)
  end

  table.sort(sessions)

  return sessions
end

---@param session string?
function M.load(session)
  if not session then
    vim.ui.select(M.list(), { prompt = "Session" }, function(choice)
      session = choice
    end)
  end

  local config = M.config()

  if not session or session == "" or vim.fn.filereadable(config.dir .. "/" .. session) == 0 then
    vim.notify("session: could not find session '" .. (session or "") .. "'", vim.log.levels.WARN)
    return
  end

  M.update()

  vim.cmd "silent! %bwipeout"
  vim.cmd.source(config.dir .. "/" .. session)
end

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
