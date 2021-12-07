local function DefaultCMD(projectName, fileName)
  local opt = {
    cargo = {
      run = "cargo run",
      build = "cargo build",
      fmt = "cargo fmt"
    },
    nimble = {
      run = "nimble run",
      build = "nimble build"
    },
    cmake = {
      run = [[cmake -GNinja -DCMAKE_BUILD_TYPE:STRING=Debug -B build/ -S ./ && ninja -C build/ && ./build/]] .. projectName,
      build = "cmake -GNinja -DCMAKE_BUILD_TYPE:STRING=Debug -B build/ -S ./ && ninja -C build/",
    },
    rustc = {
      run = "rustc -c " .. projectName .. " -o /tmp/" .. projectName .. " && /tmp/" .. projectName,
      compile = "rustc -c " .. projectName .. " -o /tmp/" .. projectName,

    },
    yarn = {
      run = "yarn start",
      build = "yarn build"
    },
    npm = {
      run = "npm run start",
      build = "npm run build"
    },
    python = {
      run = "python " .. fileName
    }
  }
  return opt
end

