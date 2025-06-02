package main

import (
	"fmt"
	"os"
	"strconv"
)

var hexToCharDict = map[int]int{
	48: 0,  // '0'
	49: 1,  // '1'
	50: 2,  // '2'
	51: 3,  // '3'
	52: 4,  // '4'
	53: 5,  // '5'
	54: 6,  // '6'
	55: 7,  // '7'
	56: 8,  // '8'
	57: 9,  // '9'
	97: 10, // 'a'
	98: 11, // 'b'
	99: 12, // 'c'
	100: 13, // 'd'
	101: 14, // 'e'
	102: 15, // 'f'
	65: 10, // 'A'
	66: 11, // 'B'
	67: 12, // 'C'
	68: 13, // 'D'
	69: 14, // 'E'
	70: 15, // 'F'
}

const reset = "\033[0m"

var (
	green   = "#8ec07c"
	red  	= "#CC241D" 
)

func hexToRGB(hexStr string) string {
	if hexStr[0] == '#' {
		hexStr = hexStr[1:]
	}
	r, _ := strconv.ParseUint(hexStr[0:2], 16, 8)
	g, _ := strconv.ParseUint(hexStr[2:4], 16, 8)
	b, _ := strconv.ParseUint(hexStr[4:6], 16, 8)
	return fmt.Sprintf("\033[38;2;%d;%d;%dm", r, g, b)
}

func printColored(msg string, color string){
	fmt.Printf("%s%s%s", hexToRGB(color), msg, reset)
}

func noArgsProvided(){
	msg := "Error: No hexadecimal provided!\nPlease specify hexadecimal like so:\nhx 48656C6C6F20576F726C64\n"
	printColored(msg, red)
}

func illegalHexException(){
	printColored("Error: The number provided contains non-hexadecimal characters!\n", red)
	os.Exit(1)
}

func oddSizeException(){
	printColored("Error: hx supports only hex numbers with even size!\n", red)
	os.Exit(1)
}

func inRange(n int) bool {
	if ((n >= 48) && (n <= 57)) || ((n >= 97) && (n <= 102)) || ((n >= 65) && (n <= 70)) {
		return true
	}
	return false 
}

func hexToDecimal(hx string, i int, hex_len int ) int {
	if i+1 >= hex_len {
		oddSizeException()
	}
	var char1 = int(hx[i])
	var char2 = int(hx[i+1])

	if !inRange(char1) || !inRange(char2) {
		illegalHexException()
	}

	sub1, sub2 := hexToCharDict[int(char1)], hexToCharDict[int(char2)]

	return sub1 * 16 + sub2
}

func hexToASCII(hx string){
	var length = len(hx)
	var output string
	for i:=0; i < length; i=i+2 {
		output += string(byte(hexToDecimal(hx, i, length)))
	}
	output += "\n"
	printColored(output, green)
}

func main(){
	args := os.Args

	if len(args) == 1{
		noArgsProvided()
		os.Exit(1)
	}

	for i:=1; i < len(args); i++ {
		hexToASCII(args[i])
	}

}
