local line = vim.fn.line

vim.g.nvim_lastplace_ignore_filetypes = vim.g.nvim_lastplace_ignore_filetypes
  or { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' }

function _G.___nvim_lastplace()
  if
    vim.bo.buftype ~= ''
    or vim.tbl_contains(vim.g.nvim_lastplace_ignore_filetypes, vim.bo.filetype)
  then
    return
  end

  local last_position = line [['"]]
  local last_line = line '$'

  if last_position > 0 and last_position <= last_line then
    local cmd
    if line 'w$' == last_line then
      cmd = [[normal! g`"]]
    elseif last_line - last_position > ((line 'w$' - line 'w0') / 2) - 1 then
      cmd = [[normal! g`"zz]]
    else
      cmd = [[normal! G'"<c-e>]]
    end
    vim.cmd(cmd)
  end
end

vim.cmd [[autocmd BufReadPost * lua ___nvim_lastplace()]]
