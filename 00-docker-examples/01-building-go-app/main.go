package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
)

var (
	configFile string
)

type Config struct {
	Message string `json:"message"`
	Args    []any  `json:"args"`
}

func main() {
	flag.StringVar(&configFile, "config", "config.json", "config file")
	flag.Parse()

	f, err := os.Open(configFile)
	if err != nil {
		panic(err)
	}
	defer f.Close()

	config := &Config{}

	// load config
	err = json.NewDecoder(f).Decode(config)
	if err != nil {
		panic(err)
	}

	// print message
	fmt.Printf(config.Message, config.Args...)
}
