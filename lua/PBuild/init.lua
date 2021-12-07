local M = {}

local function loadConfig(path)
  local contents = ''
  local file = io.open(path, "r")

  if file then
    contents = file:read("*a")
    local ok, res = pcall(vim.fn.json_decode, contents)
    io.close(file)
    if ok then
      return res
    else
      return nil
    end
  end

end

local function promptWin(command)
  vim.cmd("belowright 8 split term://" .. command)
end

M.runProject = function ()
    
end

M.setup = function ()
  local findfile = vim.fn.findfile
  if findfile('Cargo.toml', ';') ~= '' then
    vim.g.projectType = 'cargo'
  elseif findfile('*.nimble', ';') ~= '' then
    vim.g.projectType = 'nimble'
  elseif findfile('CMakeLists.txt', ';')  ~= '' then
    vim.g.projectType = 'cmake'
  elseif findfile('yarn.lock', ';')  ~= '' then
    vim.g.projectType = 'yarn'
  elseif findfile('package-lock.json', ';')  ~= '' then
    vim.g.projectType = 'npm'
  elseif findfile('package-lock.json', ';')  ~= '' then
    vim.g.projectType = 'npm'
  end
  print(vim.g.projectType)
end

M.setup()
return M
