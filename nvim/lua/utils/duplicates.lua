local X = {}

local duplicates = {
  n = {},
  v = {},
  i = {},
  s = {},
  x = {},
}

local function check_and_set_duplicates(input, description, should_check, store)
  if should_check then
    local found = store[input]
    if found ~= nil and found ~= description then
      print(string.format("%s already mapped (%s), cannot re-map (%s)", input, found, description))
    end
    store[input] = description
  end
end

--- Check duplicate keymaps
--- @param mode string | table: single mode ("n") or table of modes {"n", "v"}
--- @param input string: key sequence
--- @param description string: description
function X.check_duplicates(mode, input, description)
  local modes_to_check = { n = false, v = false, i = false, s = false, x = false }

  if type(mode) == "table" then
    for _, m in ipairs(mode) do
      if modes_to_check[m] ~= nil then
        modes_to_check[m] = true
      end
    end
  else
    if modes_to_check[mode] ~= nil then
      modes_to_check[mode] = true
    end
  end

  for m, should_check in pairs(modes_to_check) do
    check_and_set_duplicates(input, description, should_check, duplicates[m])
  end
end

return X
