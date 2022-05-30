--- Quick script to decode hexadecimal into ASCII text
-- @autor Evgeni Genchev

local hexToCharDict = {
	["0"] = 0,
	["1"] = 1,
	["2"] = 2,
	["3"] = 3,
	["4"] = 4,
	["5"] = 5,
	["6"] = 6,
	["7"] = 7,
	["8"] = 8,
	["9"] = 9,
	["a"] = 10,
	["b"] = 11,
	["c"] = 12,
	["d"] = 13,
	["e"] = 14,
	["f"] = 15,
	["A"] = 10,
	["B"] = 11,
	["C"] = 12,
	["D"] = 13,
	["E"] = 14,
	["F"] = 15,
}

local function noArgsProvidedException()
	print("\27[31mNo hexadecimal provided!\nPlease specify hexadecimal like so:\nhx 48656C6C6F20576F726C64\27[0m")
	os.exit()
end

local function illegalHexException()
	print("\27[31mThe number provided contains non-hexadecimal characters!\27[0m")
	os.exit()
end

local function oddSizeException()
	print("\27[31mhx supports only hex numbers with even size!\27[0m")
	os.exit()
end


--- Coverts a pair hexadecimal numbers in decimal
-- @param hx The hexadecimal number.
-- @param i The index of the first hexadecimal number of the pair.
-- @param hex_len The length of hx.
-- @return A decimal number decoded from the hx parameter.
local function hexToDecimal(hx, i, hex_len)

	local sub1 = hexToCharDict[hx:sub(i, i)]
	i = i + 1
	if i > hex_len then oddSizeException() end
	local sub2 = hexToCharDict[hx:sub(i, i)]

	if sub1 and sub2 then
		return sub1 * 16 + sub2
	end
	illegalHexException()
end


--- Coverts a hexadecimal number into a string and then prints it.
-- @param hx The hexadecimal number.
local function hexToASCII(hx)
	local ascii = ""
	local hex_len = string.len(hx)
	for i = 1, hex_len, 2 do
		ascii = ascii .. string.char(hexToDecimal(hx, i, hex_len))
	end
	print(ascii)
end

--- Main function
-- @param arg command line argument
local function main(arg)

	if not arg then noArgsProvidedException() end

	hexToASCII(arg)
end

main(...)
