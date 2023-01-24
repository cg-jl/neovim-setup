local function options(opts)
	if opts.global ~= nil then
		for key, value in pairs(opts.global) do
			vim.api.nvim_set_option(key, value)
		end
	end
	if opts.window ~= nil then
		for key, value in pairs(opts.window) do
			vim.api.nvim_set_option(key, value)
			vim.wo[key] = value
		end
	end
	if opts.buffer ~= nil then
		for key, value in pairs(opts.buffer) do
			vim.api.nvim_set_option(key, value)
			vim.bo[key] = value
		end
	end
end

local function keys(opts)
	local function map_key(mode, key, obj, opts)
		local rhs = ""
		opts.noremap = true

		if type(obj) ~= "table" then
			rhs = obj
		elseif obj.expr ~= nil then
			rhs = obj.expr
			opts.expr = true
		elseif obj.cmd ~= nil then
			rhs = "<cmd>" .. obj.cmd .. "<cr>"
			opts.silent = true
		else
			rhs = obj[1]
		end

		vim.keymap.set(mode, key, rhs, opts)
	end

	if opts.visual ~= nil then
		for key, target in pairs(opts.visual) do
			map_key("v", key, target, (type(target) == "table" and target.opts) or {})
		end
	end
	if opts.insert ~= nil then
		for key, target in pairs(opts.insert) do
			map_key("i", key, target, (type(target) == "table" and target.opts) or {})
		end
	end
	if opts.normal ~= nil then
		for key, target in pairs(opts.normal) do
			map_key("n", key, target, (type(target) == "table" and target.opts) or {})
		end
	end
end

local function vars(tbl)
	for key, val in pairs(tbl) do
		vim.g[key] = val
	end
end

return {
	keys = keys,
	options = options,
	vars = vars,
}
