package main

import (
	"errors"
	"fmt"
	"testing"
)

func TestGO(t *testing.T) {
	fmt.Println(1)
	println(2)

	err := errors.New("k")
	if err != nil {
		return nil
	}

	
}

func TestTT(t *testing.T) {
}

type Us struct {
	Name string
	Age  int
}

