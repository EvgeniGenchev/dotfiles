--- Script that generates project layouts based on language\framework and licenses
-- @author Evgeni Genchev
-- @license MIT

local p_name, p_type, l_type = ...


local supportedLicenses = {
["mit"] = true,["apache"] = true,
["isc"] = true, ["bsd"] = true,
["gpl3"] = true
}

local supportedProjects = {
["pentest"] = 1, ["python"] = 2,
["c"] = 3, ["c++"] = 4,
["fast_api"] = 5, ["lua"] = 6,
["playdate"] = 7, ["fastapi"] = 8,
["fastapi-web"] = 9
}

function NoProjectNameException()
	print("No project name provided!")
	print("Syntax: mkprj <PROJECT NAME> <PROJECT_TYPE>")
	os.exit()
end


function NoProjectTypeException()
	print("No project type provided!")
	print("Syntax: mkprj <PROJECT NAME> <PROJECT_TYPE>")
	os.exit()
end


function IllegalProjectTypeException(p_type)
	print("Project type '" .. p_type .. "' not supported")
	print("Supported types: pentest, python, c, c++, fast_api")
	os.exit()
end

function IllegalLicenseException(l_type)
	print("License type '" .. l_type .. "' not supported")
	print("Supported types: mit, apache, isc, bsd, gpl3")
	os.exit()
end


--- Strips spaces from end and start of the sting
-- @param str A string that needs "trimming"
-- @return Stripped string
local function strip(str)
	local n = string.len(str)

	local startIndex, endIndex = 0, 0

	--- Iterate over a string and log the empty whitespace before the string
	-- @param strg The string that is going to be checked
	-- @param pos The position till when the string should be checked
	-- @retun count The count of whitespaces before a the first letter
	local function spaceChecker(strg, pos)
		local count = 0
		for i = 1, pos, 1 do
			if strg:sub(i,i) == " " then
				count = count + 1
			else break end
		end
		return count
	end

	startIndex = spaceChecker(str, n) + 1
	endIndex = n - spaceChecker(str:reverse(), n - startIndex)

	return str:sub(startIndex, endIndex)

end

--- Check if the all the arguments are present and legal
local function check_args()
	if not p_name then
		NoProjectNameException()
	else
		p_type = strip(p_type:lower())

		if not p_type then
			NoProjectTypeException()
		end
		if not supportedProjects[p_type] then
			IllegalProjectTypeException(p_type)
		end
		if not (l_type==nil) then

			l_type = strip(l_type:lower())

			if not supportedLicenses[l_type] then
				IllegalLicenseException(l_type)
			end
		end
	end

end


local function python(projectName, licenseName)
	os.execute("mkdir -p " .. projectName .. "/" .. projectName )

	if not (licenseName == nil) then
		--- TODO: Needs formatting of licenses
		os.execute("echo " .. supportedLicenses[licenseName] .. " > " .. projectName .. "/LICENSE")
	end
	os.execute("touch " .. projectName ..  "/requirements.txt")
	os.execute('echo "#' .. projectName .. '\n" > '.. projectName ..'/README.md')
	os.execute("mkdir " .. projectName .. "/tests")
	os.execute("touch " .. projectName .. "/setup.py")
	os.execute("touch "..projectName.."/"..projectName.."/main.py "..projectName.."/"..projectName.."/".."__init__.py")


end

local function pentest(projectName)
	os.execute("mkdir -p " .. projectName .. "/EPT/evidence/credentials")
	os.execute("mkdir " .. projectName .. "/EPT/evidence/data")
	os.execute("mkdir " .. projectName .. "/EPT/evidence/screenshots")
	os.execute("mkdir " .. projectName .. "/EPT/logs")
	os.execute("mkdir " .. projectName .. "/EPT/scans")
	os.execute("mkdir " .. projectName .. "/EPT/scope")
	os.execute("mkdir " .. projectName .. "/EPT/tools")


	os.execute("mkdir -p " .. projectName .. "/IPT/evidence/credentials")
	os.execute("mkdir " .. projectName .. "/IPT/evidence/data")
	os.execute("mkdir " .. projectName .. "/IPT/evidence/screenshots")
	os.execute("mkdir " .. projectName .. "/IPT/logs")
	os.execute("mkdir " .. projectName .. "/IPT/scans")
	os.execute("mkdir " .. projectName .. "/IPT/scope")
	os.execute("mkdir " .. projectName .. "/IPT/tools")
end

local function playdate(projectName)
	os.execute("mkdir -p " .. projectName .. "/source/images")
	os.execute("mkdir -p " .. projectName .. "/source/sounds")
	os.execute("mkdir -p " .. projectName .. "/support")
	os.execute("touch " .. projectName .. "/source/main.lua")
end


local function cpp(projectName, licenseName)
	os.execute("mkdir -p " .. projectName .. "/include")
	os.execute("mkdir -p " .. projectName .. "/src")
	os.execute("mkdir -p " .. projectName .. "/test")
	os.execute("mkdir -p " .. projectName .. "/libs")
	os.execute("touch " .. projectName .. "/CMakeLists.txt")
	os.execute("touch " .. projectName .. "/src/main.cpp")
	local file = io.open(projectName .. "/CMakeLists.txt", "w")
	file:write([[cmake_minimum_required(VERSION %.2f)
project(%s)

set(CMAKE_CXX_STANDARD %d)
add_executable(%s src/main.cpp)]])
	file:close()

end

local function _lua(projectName, licenseName)
	os.execute("mkdir -p " .. projectName .. "/bin")
	os.execute("mkdir -p " .. projectName .. "/test")
	os.execute("mkdir -p " .. projectName .. "/src")
	os.execute("touch " .. projectName .. "/src/main.lua")
end

local function _fastapi(projectName)
	os.execute("mkdir -p " .. projectName .. "/static")
	os.execute("mkdir -p " .. projectName .. "/static/css")
	os.execute("mkdir -p " .. projectName .. "/static/images")
	os.execute("mkdir -p " .. projectName .. "/static/js")
	os.execute("touch " .. projectName .. "/static/index.html")
	os.execute("touch " .. projectName .. "/main.py")
	os.execute([[echo "<!DOCTYPE html>
	<html>
		<head>
			<title>Page Title</title>
		</head>
		<body>
			<p>Hello World</p>
		</body>
		</html>" >> ]] .. projectName .. "/static/index.html")
end

local function c(projectName, licenseName) end
local function fast_api(projectName, licenseName) end


check_args()

local pwd = os.getenv("PWD")
os.execute("cd " .. pwd)
local index = supportedProjects[p_type]

if index==1 then pentest(p_name)
elseif index==2 then python(p_name, l_type)
elseif index==3 then c(p_name, l_type)
elseif index==4 then cpp(p_name, l_type)
elseif index==5 then fast_api(p_name, l_type)
elseif index==6 then _lua(p_name, l_type)
elseif index==7 then playdate(p_name)
elseif index==9 then _fastapi(p_name)
end
