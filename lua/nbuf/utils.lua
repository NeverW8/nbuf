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

local icon_cache = {}

function M.get_file_icon(filename)
  if not filename or filename == '' then
    return '󰈙'
  end
  
  -- Check cache first
  if icon_cache[filename] then
    return icon_cache[filename]
  end
  
  local icon = '󰈙'
  local lower_name = filename:lower()
  
  if lower_name == 'dockerfile' then
    icon = file_icons.dockerfile
  elseif lower_name == 'makefile' then
    icon = file_icons.makefile
  elseif lower_name == 'cmakelists.txt' then
    icon = file_icons.cmake
  else
    local dot_pos = filename:find('%.[^%.]*$')
    if dot_pos then
      local ext = filename:sub(dot_pos + 1):lower()
      icon = file_icons[ext] or '󰈙'
    else
      if lower_name:find('gitignore') then
        icon = file_icons.gitignore
      elseif lower_name:find('license') then
        icon = file_icons.license
      elseif lower_name:find('readme') then
        icon = file_icons.readme
      end
    end
  end
  
  icon_cache[filename] = icon
  return icon
end

return M
