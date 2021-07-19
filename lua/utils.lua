local function map(mode, lhs, rhs, more_options_3f)
  local options = {noremap = true, silent = true}
  if more_options_3f then
    options = vim.tbl_extend("force", options, more_options_3f)
  end
  return vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local function is_in_table(tbl, value)
  for _, v in ipairs(tbl) do
    if (v == value) then
      return true
    end
  end
  return false
end
local function options(scope, kvpairs)
  local scope_index
  do
    local _0_0 = scope
    if (_0_0 == "global") then
      scope_index = "o"
    elseif (_0_0 == "buffer") then
      scope_index = "bo"
    elseif (_0_0 == "window") then
      scope_index = "wo"
    else
    scope_index = nil
    end
  end
  local tset_fn
  if (scope ~= "global") then
    local function _1_(k, v)
      vim[scope_index][k] = v
      vim.o[k] = v
      return nil
    end
    tset_fn = _1_
  else
    local function _1_(k, v)
      vim[scope_index][k] = v
      return nil
    end
    tset_fn = _1_
  end
  for k, v in pairs(kvpairs) do
    tset_fn(k, v)
  end
  return nil
end
local function make_command(name)
  return (":" .. name .. "<cr>")
end
local function map_command(mode, lhs, rhs, more_options_3f)
  return map(mode, lhs, make_command(rhs), more_options_3f)
end
local function set_global(key, value)
  vim.g[key] = value
  return nil
end
local function set_globals(kvpairs)
  for k, v in pairs(kvpairs) do
    vim.g[k] = v
  end
  return nil
end
local function prefix_options(prefixes, kvpairs)
  local tbl = {}
  local built_prefix = (table.concat(prefixes, "_") .. "_")
  for k, v in pairs(kvpairs) do
    tbl[(built_prefix .. k)] = v
  end
  return tbl
end
local function env()
  local variables = {}
  for k, v in pairs(vim.fn.environ()) do
    table.insert(variables, string.format("%s=%s", k, v))
  end
  return variables
end
local function merge_tables(a, b)
  local function is_type(v, type_name)
    return (type(v) == type_name)
  end
  local function both_have_type(a0, b0, type_name)
    return (is_type(a0, type_name) and is_type(b0, type_name))
  end
  local merged = {}
  for k, v in pairs(a) do
    merged[k] = v
  end
  for k, v in pairs(b) do
    local other_value = a[k]
    local _0_
    if both_have_type(v, other_value, "table") then
      _0_ = merge_tables(v, other_value)
    else
      _0_ = v
    end
    merged[k] = _0_
  end
  return merged
end
return {["is-in-table"] = is_in_table, ["make-command"] = make_command, ["map-command"] = map_command, ["merge-tables"] = merge_tables, ["prefix-options"] = prefix_options, ["set-global"] = set_global, ["set-globals"] = set_globals, map = map, options = options}
