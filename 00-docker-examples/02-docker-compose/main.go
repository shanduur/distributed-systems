package main

import (
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"
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

	// handle signals
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGINT, syscall.SIGTERM)

	ctx, cancel := context.WithCancel(context.Background())

	// catch signals
	go func() {
		<-c
		cancel()
	}()

	// open config file
	f, err := os.Open(configFile)
	if err != nil {
		log.Fatal(err)
	}
	// close file when main function ends
	defer f.Close()

	config := &Config{}

	// load config
	err = json.NewDecoder(f).Decode(config)
	if err != nil {
		log.Fatal(err)
	}

	run(ctx, config)
}

func run(ctx context.Context, config *Config) {
	// create ticker that ticks every 5 seconds
	// it sends signal to channel C
	ticker := time.NewTicker(5 * time.Second)

	// infinite loop
	for {
		select {
		case <-ctx.Done():
			log.Println("done")
			return

		case <-ticker.C:
			fmt.Printf(config.Message, config.Args...)
		}
	}
}
