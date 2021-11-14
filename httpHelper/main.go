package main

import "C"
import (
	"context"
	"io"
	"net/http"
	"net/url"
	"time"
)

//go:generate go build -buildmode=c-shared  -o httpHelper.dll .\main.go

//export Quote
func Quote(str *C.char) *C.char {
	urlStr := C.GoString(str)
	escapeUrl := url.QueryEscape(urlStr)
	return C.CString(escapeUrl)
}

// http helper for only get method
// args: url
//export HttpGet
func HttpGet(cUrl *C.char) *C.char {
	// log.Printf("request url is: %s", url)
	url := C.GoString(cUrl)
	client := http.Client{}
	ctx, cancel := context.WithTimeout(context.TODO(), 2*time.Second)
	defer cancel()
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return errString(err)
	}
	resp, err := client.Do(req)
	if err != nil {
		return errString(err)
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return errString(err)
	}
	return C.CString(string(body))
}

func errString(err error) *C.char {
	return C.CString(err.Error())
}

func main() {}
