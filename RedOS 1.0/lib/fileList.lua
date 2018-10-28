local fileList = {}

local filesystem = require("filesystem")
local component = require("component")
local gpu = component.gpu

function fileList.list(path, page)

  local e = 1
  local k = 1
  local j = 1

  local i 
  local files = {}
  local allFiles = {}

  for i in filesystem.list(path) do
    allFiles[e] = i
    e = e + 1
  end

  table.sort(allFiles)

  for i = 1, #allFiles do
    if (k > ((page - 1) * 12)) and (k <= (page * 12)) then
      files[j] = allFiles[i]
      j = j + 1
    end
    k = k + 1
  end  

  for i = 1, 12 do
    if i > #files then break
    else  
      gpu.set(1, 2 + i, files[i])
    end
  end
  
  return files  

end

function fileList.pages(path)

  local pages
  local i
  local k = 0

  for i in filesystem.list(path) do
    k = k + 1
  end

  pages = k / 12
  pages = math.ceil(pages)  

  return pages  

end

return fileList