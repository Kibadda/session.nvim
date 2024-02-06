# session.nvim

small session management plugin

## Installation

install with your favorite plugin manager, e.g. [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "Kibadda/session.nvim",
  opts = {},
}
```

## Configuration

```lua
{
  save_on_vim_leave = true,
  hooks = {
    ---@type table<"save"|"delete"|"load", function?>
    pre = {
      save = nil,
      delete = nil,
      load = nil,
    },
    ---@type table<"save"|"delete"|"load", function?>
    post = {
      save = nil,
      delete = nil,
      load = nil,
    },
  },
  dir = vim.fn.stdpath "data" .. "/session",
}
```

## Api

```lua
require("session").setup()
require("session").new()
require("session").load()
require("session").update()
require("session").delete()
require("session").list()

require("session.utils").check()
require("session.utils").current()
require("session.utils").hooks()
```
