package beatsage

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
)

const (
	requestUrl = `https://beatsage.com/youtube_metadata`
	testSong = `https://www.youtube.com/watch?v=yqu2BcD4-ow&list=PL9tY0BWXOZFsJkwRHQO9yDJh2UimW0VUY`
)

var (
	youtubeData = make(map[string]string, 0)
)
func GetYoutubeData() {
	youtubeData["youtube_url"] = testSong
	byteData, _ := GetPayload(youtubeData)
	resp, err := http.Post(requestUrl, "application/json", bytes.NewBuffer(byteData))
	if err != nil {
		log.Fatalf("request failed %s", err)
	}

	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatalln(err)
	}

	log.Println(string(body))
}

func GetPayload(data map[string]string) ([]byte, error){
	req, err := json.Marshal(data)
	if err != nil {
		log.Fatalf("marsahl failed %s", err)
		return nil, err
	}
	return req, nil
}