# NBuf

A simple and efficient buffer manager for Neovim that provides a floating window interface to navigate and manage your open buffers.

![NBuf Showcase](https://raw.githubusercontent.com/NeverW8/nbuf/ut.gif)

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "NeverW8/nbuf",
  config = function()
    require("nbuf").setup()
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "NeverW8/nbuf",
  config = function()
    require("nbuf").setup()
  end
}
```

## Usage

### Default Keybindings

Add this to your Neovim configuration to set up a keybinding:

```lua
vim.keymap.set('n', '<leader>b', require('nbuf').toggle, { desc = 'Toggle NBuf' })
```

### Buffer Manager Keybindings

When the NBuf window is open:

| Key | Action |
|-----|--------|
| `j` / `k` | Navigate up/down |
| `h` / `l` | Navigate up/down (alternative) |
| `<CR>` | Jump to selected buffer |
| `dd` | Delete selected buffer |
| `q` / `<Esc>` | Close NBuf window |


## API

### Functions

- `require("nbuf").toggle()` - Toggle the NBuf window
- `require("nbuf").open()` - Open the NBuf window
- `require("nbuf").close()` - Close the NBuf window

## Requirements

- Neovim >= 0.7.0

