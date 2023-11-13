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
    pre = {
      save = function() end,
      delete = function() end,
      load = function() end,
    },
    post = {
      save = function() end,
      delete = function() end,
      load = function() end,
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
