package main

import (
	"fmt"
	"os"
	"strconv"
)

const reset = "\033[0m"

var (
	env   = "#B380C2" 
	value = "#FBF1C7" 
	sign  = "#CC241D" 
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

func main() {
	envColor := hexToRGB(env)
	valueColor := hexToRGB(value)
	signColor := hexToRGB(sign)

	for _, env := range os.Environ() {
		pair := splitEnv(env)
		fmt.Printf("%s%s%s%s=%s%s%s%s\n", envColor, pair[0], reset, signColor, reset, valueColor, pair[1], reset)
	}
}

func splitEnv(env string) [2]string {
	i := 0
	for ; i < len(env); i++ {
		if env[i] == '=' {
			break
		}
	}
	key := env[:i]
	value := env[i+1:]
	return [2]string{key, value}
}

