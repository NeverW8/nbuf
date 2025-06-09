local ui = require('nbuf.ui')

local M = {}

M.is_open = false
M.win_id = nil
M.buf_id = nil

function M.toggle()
  if M.is_open then
    M.close()
  else
    M.open()
  end
end

function M.open()
  if M.is_open then
    return
  end
  
  M.win_id, M.buf_id = ui.create_window()
  M.is_open = true
  ui.render_buffers(M.buf_id)
  ui.setup_keymaps(M.buf_id, M)
end

function M.close()
  if not M.is_open then
    return
  end
  
  if M.win_id and vim.api.nvim_win_is_valid(M.win_id) then
    vim.api.nvim_win_close(M.win_id, true)
  end
  
  M.is_open = false
  M.win_id = nil
  M.buf_id = nil
end

function M.jump_to_buffer()
  local line = vim.api.nvim_win_get_cursor(M.win_id)[1]
  local buffers = ui.get_listed_buffers()
  
  if line <= #buffers then
    local buf_id = buffers[line]
    M.close()
    vim.api.nvim_set_current_buf(buf_id)
  end
end

function M.delete_buffer()
  local line = vim.api.nvim_win_get_cursor(M.win_id)[1]
  local buffers = ui.get_listed_buffers()
  
  if line <= #buffers then
    local buf_id = buffers[line]
    vim.api.nvim_buf_delete(buf_id, { force = false })
    ui.render_buffers(M.buf_id)
    
    local new_buffers = ui.get_listed_buffers()
    if line > #new_buffers and #new_buffers > 0 then
      vim.api.nvim_win_set_cursor(M.win_id, { #new_buffers, 0 })
    end
    
    if #new_buffers == 0 then
      M.close()
    end
  end
end

function M.setup(opts)
  opts = opts or {}
end

return M
