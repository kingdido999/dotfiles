local utils = {}

function utils.isModuleAvailable(name)
  local ok, _ = pcall(require, name)
  if ok then
    return true
  else
    return false
  end
end

return utils
