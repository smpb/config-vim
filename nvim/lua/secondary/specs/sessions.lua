-- Session loading

local function get_cwd_sessions()
  return vim.fn.glob(vim.fn.getcwd() .. "/*.vim", false, true)
end

local function pick_session_or_files()
  local fzf = require("fzf-lua")
  local sessions = get_cwd_sessions()

  if #sessions > 0 then
    -- optional: sort by most recent
    table.sort(sessions, function(a, b)
      return vim.fn.getftime(a) > vim.fn.getftime(b)
    end)

    local selected = false

    fzf.fzf_exec(sessions, {
      prompt = "Sessions> ",
      actions = {
        ["default"] = function(sel)
          if not sel or #sel == 0 then return end
          selected = true
          vim.cmd("source " .. vim.fn.fnameescape(sel[1]))
        end,
      },
      winopts = {
        on_close = function()
          vim.defer_fn(function()
            if not selected then
              require("fzf-lua").files()
            end
          end, 50)
        end,
      },
    })
  else
    fzf.files()
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.argc() == 0
      and vim.bo.buftype == ""
    then
      vim.defer_fn(function()
        pick_session_or_files()
      end, 50)
    end
  end,
  once = true  -- Run only once during startup
})
