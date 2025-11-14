package main

import (
	"fmt"
	"log"
	"log/slog"
	"net/http"
	"os"
)

func init() {
	jsonLogger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	slog.SetDefault(jsonLogger)
}

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "world")
	})

	slog.Info("server running on", slog.Any("port", "8080"))
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("server err", err)
	}
}
