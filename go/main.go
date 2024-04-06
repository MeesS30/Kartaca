package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
)

type Country struct {
	Ulke    string `json:"ulke"`
	Nufus   int    `json:"nufus"`
	Baskent string `json:"baskent"`
}

func IndexHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Merhaba Go!")
}

func RandomCountryHandler(w http.ResponseWriter, r *http.Request) {
	esURL := "http://es01:9200/ulkeler/_search"

	response, err := http.Get(esURL)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer response.Body.Close()

	var data map[string]interface{}
	if err := json.NewDecoder(response.Body).Decode(&data); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	hits := data["hits"].(map[string]interface{})["hits"].([]interface{})
	randomIndex := rand.Intn(len(hits))
	randomCountry := hits[randomIndex].(map[string]interface{})["_source"].(map[string]interface{})

	country := Country{
		Ulke:    randomCountry["ulke"].(string),
		Nufus:   int(randomCountry["nufus"].(float64)),
		Baskent: randomCountry["baskent"].(string),
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(country)
}

func main() {
	http.HandleFunc("/", IndexHandler)
	http.HandleFunc("/staj", RandomCountryHandler)

	fmt.Println("Server started on port 5555...")
	log.Fatal(http.ListenAndServe(":5555", nil))
}