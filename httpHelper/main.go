package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"os"
	"time"
)

// http helper for only get method
// args: url
func main() {
	if len(os.Args) < 3 {
		return
	}
	barkToken := os.Args[1]
	title := os.Args[2]
	if barkToken == "" || title == "" {
		log.Fatalln("need both token and title to work")
	}
	// message := os.Args[3]
	icon := "https://cdn-icons-png.flaticon.com/512/610/610021.png"
	group := "来自PC"
	url := fmt.Sprintf("https://api.day.app/%s/%s?group=%s&icon=%s", barkToken, quote(title), quote(group), quote(icon))
	httpReq(url)
}

func httpReq(url string) {
	log.Printf("request url is: %s", url)
	client := http.Client{}
	ctx, cancel := context.WithTimeout(context.TODO(), 2*time.Second)
	defer cancel()
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	errHandler(err)
	_, err = client.Do(req)
	// log.Println(resp)
	errHandler(err)
}

func quote(str string) (escapeUrl string) {
	escapeUrl = url.QueryEscape(str)
	return
}

func errHandler(err error) {
	if err != nil {
		log.Fatalf("request fail, detail: %s", err)
	}
}
