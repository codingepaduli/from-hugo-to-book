function fix_path (path)
  if string.starts(path, "/static") then
    return '.' .. path
	-- replace function doesn't work
	-- return string.gsub(string,"/static/","./static/")
  end
  return path
end

-- Checks if a string start with "Start" variable
function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- Replace image path
function Image (element)
  element.src = fix_path(element.src)
  return element
end

--[[
   Replace link path; This has been commented;
function Link (element)
  element.target = fix_path(element.target)
  return element
end
]]--
