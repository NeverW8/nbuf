local utils = require('nbuf.utils')

local M = {}

function M.get_listed_buffers()
  local buffers = {}
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf_id) and vim.bo[buf_id].buflisted then
      table.insert(buffers, buf_id)
    end
  end
  return buffers
end

function M.create_window()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  local buf_id = vim.api.nvim_create_buf(false, true)
  
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' NBuf ',
    title_pos = 'center',
  }
  
  local win_id = vim.api.nvim_open_win(buf_id, true, win_opts)
  
  vim.bo[buf_id].modifiable = false
  vim.bo[buf_id].readonly = true
  vim.bo[buf_id].buftype = 'nofile'
  vim.bo[buf_id].bufhidden = 'wipe'
  vim.bo[buf_id].swapfile = false
  
  vim.wo[win_id].cursorline = true
  vim.wo[win_id].number = false
  vim.wo[win_id].relativenumber = false
  vim.wo[win_id].wrap = false
  
  return win_id, buf_id
end

function M.render_buffers(buf_id)
  local buffers = M.get_listed_buffers()
  local lines = {}
  
  if #buffers == 0 then
    lines = { "No buffers available" }
  else
    for i, buffer_id in ipairs(buffers) do
      local name = vim.api.nvim_buf_get_name(buffer_id)
      local filename = vim.fn.fnamemodify(name, ':t')
      local filepath = vim.fn.fnamemodify(name, ':h')
      
      if filename == '' then
        filename = '[No Name]'
        filepath = ''
      end
      
      local icon = utils.get_file_icon(filename)
      
      local line = string.format("%d %s %-20s %s", 
        i, 
        icon, 
        filename,
        filepath ~= '' and filepath or ''
      )
      
      table.insert(lines, line)
    end
  end
  
  vim.bo[buf_id].modifiable = true
  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  vim.bo[buf_id].modifiable = false
end

function M.setup_keymaps(buf_id, manager)
  local opts = { buffer = buf_id, silent = true, nowait = true }
  
  vim.keymap.set('n', 'j', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local total_lines = vim.api.nvim_buf_line_count(buf_id)
    if line < total_lines then
      vim.api.nvim_win_set_cursor(0, { line + 1, 0 })
    end
  end, opts)
  
  vim.keymap.set('n', 'k', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    if line > 1 then
      vim.api.nvim_win_set_cursor(0, { line - 1, 0 })
    end
  end, opts)
  
  vim.keymap.set('n', 'h', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    if line > 1 then
      vim.api.nvim_win_set_cursor(0, { line - 1, 0 })
    end
  end, opts)
  
  vim.keymap.set('n', 'l', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local total_lines = vim.api.nvim_buf_line_count(buf_id)
    if line < total_lines then
      vim.api.nvim_win_set_cursor(0, { line + 1, 0 })
    end
  end, opts)
  
  vim.keymap.set('n', '<CR>', function()
    manager.jump_to_buffer()
  end, opts)
  
  vim.keymap.set('n', 'dd', function()
    manager.delete_buffer()
  end, opts)
  
  vim.keymap.set('n', 'q', function()
    manager.close()
  end, opts)
  
  vim.keymap.set('n', '<Esc>', function()
    manager.close()
  end, opts)
end

return M
