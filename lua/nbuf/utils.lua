local M = {}

local file_icons = {
  lua = '󰢱',
  vim = '',
  py = '󰌠',
  js = '󰌞',
  ts = '󰛦',
  jsx = '',
  tsx = '',
  html = '󰌝',
  css = '',
  scss = '',
  sass = '',
  json = '󰘦',
  md = '󰍔',
  txt = '󰈙',
  rs = '󱘗',
  go = '󰟓',
  c = '',
  cpp = '',
  h = '',
  hpp = '',
  java = '',
  php = '',
  rb = '',
  sh = '',
  zsh = '',
  bash = '',
  fish = '',
  yml = '',
  yaml = '',
  toml = '',
  xml = '󰗀',
  sql = '',
  r = '󰟔',
  swift = '󰛥',
  kt = '󱈙',
  dart = '',
  vue = '󰡄',
  svelte = '',
  dockerfile = '󰡨',
  makefile = '',
  cmake = '',
  gitignore = '',
  license = '󰿃',
  readme = '󰍔',
}

function M.get_file_icon(filename)
  if not filename or filename == '' then
    return '󰈙'
  end
  
  local lower_name = filename:lower()
  if lower_name == 'dockerfile' then
    return file_icons.dockerfile
  elseif lower_name == 'makefile' then
    return file_icons.makefile
  elseif lower_name == 'cmakelists.txt' then
    return file_icons.cmake
  elseif lower_name:match('%.gitignore') then
    return file_icons.gitignore
  elseif lower_name:match('license') then
    return file_icons.license
  elseif lower_name:match('readme') then
    return file_icons.readme
  end
  
  local ext = filename:match('%.([^%.]+)$')
  if ext then
    ext = ext:lower()
    return file_icons[ext] or '󰈙'
  end
  
  return '󰈙'
end

return M
