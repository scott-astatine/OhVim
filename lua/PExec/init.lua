local M = {}
M.dCMD = require('PExec.defaultCMD')
local stId = require('PExec.identifiers')
local cFcmd = {}
local singleFrun = false


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

M.generateConfig = function ()
  local c = {
    pExeCMD = vim.g.pExeCMD or '',
    projectName = vim.g.projectName or '',
  }
  local ok, jsonStr = pcall(vim.fn.json_encode, c)
  if ok then
    local cFile = io.open(".PExecConf.json", "w+")
    if cFile then
      cFile:write(jsonStr)
      cFile:close()
    end
  end
end

local function walkDir(directory)
    local t, popen = "", io.popen
    local pfile = popen('ls "'..directory..'"')
    for filename in pfile:lines() do
        t = t .. " " .. filename
    end
    pfile:close()
    return t
end

M.setup = function ()
  local findfile = function (file)
    if vim.fn.findfile(file, ';') ~= '' then
      return true
    else
      return false
    end
  end
  if findfile('.PExecConf.json') then
    local confFile = loadConfig(vim.fn.getcwd() .. '/.PExecConf.json')
    if confFile then
      if confFile.projectName then
        vim.g.projectName = confFile.projectName
      end
      if confFile.pExeCMD then
        if confFile.cmd then
          cFcmd = confFile.cmd
        end
        vim.g.pExeCMD = confFile.pExeCMD
      end
    end
  else
    local dirList = walkDir(vim.fn.getcwd())
    local function dListhas(str)
      if string.match(dirList, str) then
        return true
      else
        return false
      end
    end

    -- Rust Cargo Config
    if dListhas(stId.cargo) then
      vim.g.pExeCMD = 'cargo'
    elseif dListhas(stId.rustc) then
      singleFrun = true
      vim.g.pExeCMD = 'rustc'

    -- Yarn, Npm, & Node config
    elseif dListhas(stId.yarn) then
      vim.g.pExeCMD = 'yarn'
      M.generateConfig()
    elseif dListhas(stId.npm) then
      vim.g.pExeCMD = 'npm'
      M.generateConfig()
    elseif dListhas(stId.javascript) then
      singleFrun = true
      vim.g.pExeCMD = 'node'

    -- Cmake Config
    elseif dListhas(stId.cmake) then
      vim.g.pExeCMD = 'cmake'
      M.generateConfig()
    elseif dListhas(stId.cpp) then
      singleFrun = true
      vim.g.pExeCMD = 'cpp'
    elseif dListhas(stId.lua) then
      singleFrun = true
      vim.g.pExeCMD = 'lua'

    -- Nim & Nimble config
    elseif dListhas(stId.nimble) then
      vim.g.pExeCMD = 'nimble'
    elseif dListhas(stId.nim) then
      singleFrun = true
      vim.g.pExeCMD = 'nimc'

    -- Python
    elseif dListhas(stId.django) then
      vim.g.pExeCMD = 'django'
    elseif dListhas(stId.python) then
      singleFrun = true
      vim.g.pExeCMD = 'python'
    else
      print("Could not determine which language or package manager you're using!\nDefine `cmd` run, build cmd in `.PExecConf.json file")
    end
  end
end

M.setup()

local function outputWin(command)
  vim.cmd("belowright 8 split term://" .. command)
end

M.runProject = function ()
  M.setup()
  if cFcmd.run then
    outputWin(cFcmd.run)
  else
    if singleFrun then
      outputWin(M.dCMD(vim.g.projectName, vim.fn.bufname())[vim.g.pExeCMD].run)
    elseif vim.g.pExeCMD then
      local exe = M.dCMD(vim.g.projectName)[vim.g.pExeCMD].run
      outputWin(exe)
    else
      print("Project run cmd not configured!")
    end
  end
end

M.buildProject = function ()
  M.setup()
  if cFcmd.build then
    outputWin(cFcmd.compile)
  else
    if singleFrun then
      outputWin(M.dCMD(vim.g.projectName, vim.fn.expand("%:p:~:h"))[vim.g.pExeCMD].compile)
    elseif vim.g.projectName then
      outputWin(M.dCMD(vim.g.projectName)[vim.g.pExeCMD].build)
    else
      print("Project build cmd not configured!")
    end
  end
end


return M
