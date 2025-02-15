package main

import (
	"net/http/httptest"
	"testing"
)

func TestHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/", nil)
	w := httptest.NewRecorder()
	handler(w, req)

	if w.Body.String() != "Hello, World! Multi-stage builds on CircleCI!" {
		t.Errorf("Expected response body to be 'Hello, World! Multi-stage builds on CircleCI!' but got %s", w.Body.String())
	}
}