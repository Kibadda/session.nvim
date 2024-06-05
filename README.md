# session.nvim

## Configuration
To change the default configuration, set `vim.g.session`.

Default config:
```lua
vim.g.session = {
  dir = vim.fn.stdpath "data" .. "/session",
  save_on_exit = true,
}
```

## API
This plugin exports following `<Plug>` mappings:
```
<Plug>(SessionNew) -> require("session").new()
<Plug>(SessionUpdate) -> require("session").update()
<Plug>(SessionLoad) -> require("session").load()
<Plug>(SessionDelete) -> require("session").delete()
```

Additional this plugin also exposes the function:
```lua
require("session").list()
```
