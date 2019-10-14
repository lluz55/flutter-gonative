package gonativelib

import (
	"errors"
	"fmt"
	"net/http"
	"time"
)

type (
	// Server ...
	Server struct {
	}
)

func ping(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, time.Now().Unix())
}

// Run : Start the server
func (s *Server) Run() error {
	http.HandleFunc("/ping", ping)
	err := http.ListenAndServe(":8081", nil)
	return errors.New("err: " + err.Error())
}
