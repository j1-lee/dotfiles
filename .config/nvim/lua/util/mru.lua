local mru = {}

local function get_entries()
  local files = {}
  for _, file in ipairs(vim.v.oldfiles) do
    if
      vim.startswith(file, '/home/') and
      not vim.endswith(file, 'COMMIT_EDITMSG') and
      vim.fn.filereadable(file) == 1
    then
      files[#files+1] = file
    end
    if #files == 10 then break end
  end

  local lines = {}
  for i, file in ipairs(files) do
    lines[#lines+1] = (i % 10) .. ': ' .. vim.fn.fnamemodify(file, ':~')
  end

  return files, lines
end

local function create_buffer()
  local buf = vim.api.nvim_create_buf(false, true)

  local files, lines = get_entries()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.b[buf].mru = true
  vim.bo[buf].modifiable = false

  local id = 0
  local highlight = vim.api.nvim_buf_add_highlight
  for i = 1, #files do
    local basename_start = lines[i]:len() - vim.fs.basename(files[i]):len()
    id = highlight(buf, id, 'Directory', i - 1, 2, basename_start)
    id = highlight(buf, id, 'Identifier', i - 1, basename_start, -1)
  end

  local function open(num)
    num = num or vim.fn.line('.')
    if num == 0 then num = 10 end
    if num > #files then return end
    pcall(vim.cmd.close)
    pcall(vim.cmd.edit, files[num])
  end

  for i = 0, #files-1 do
    vim.keymap.set('n', tostring(i), function() open(i) end, { buffer = buf })
  end
  vim.keymap.set('n', '<CR>', open, { buffer = buf })
  vim.keymap.set('n', 'q', vim.cmd.quit, { buffer = buf })

  local augroup = vim.api.nvim_create_augroup('mru', { clear = true })
  vim.api.nvim_create_autocmd('BufWinEnter', {
    callback = function()
      vim.opt_local.winfixheight = true
      vim.opt_local.wrap = false
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end,
    buffer = buf, group = augroup
  })

  return buf
end

function mru.is_mru(buf)
  return vim.bo[buf].buftype == 'nofile' and vim.b[buf].mru
end

function mru.show()
  local buf
  for i = 1, vim.fn.bufnr('$') do
    if mru.is_mru(i) then buf = i break end
  end

  vim.cmd.buffer(buf or create_buffer())
end

return mru
