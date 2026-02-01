local function mode()

	-- :h mode() for when adding more modes
  local map = {
    n = " NOR ",
    i = " INS ",
    v = " VIS ",
    V = " VIS ",
		c = " COM "
  }

  return vim.fn.get(map, vim.fn.mode(), '')
end

local function branch()
	local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
		if string.len(branch) > 0 then
			return branch
		else
			return ": "
		end
end

function Statusline()
	return table.concat {
		mode(),
		"%s 󱗽 ",
		" %f ",
		"%=",
		"%m",
		string.format("[%s]", branch()),
		" "
	}
end

-- v:lua.function() is a prefix used to call global Lua functions from Vimscript
vim.opt.statusline = "%!v:lua.Statusline()"

-- Show only one statusline at the bottom instead of per window
vim.opt.laststatus = 3
