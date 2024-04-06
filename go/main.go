package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"time"
)

type City struct {
	Il       string `json:"il"`
	Ilceler  string `json:"ilceler"`
}

func IndexHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Merhaba Go!")
}

func RandomCityHandler(w http.ResponseWriter, r *http.Request) {
	esURL := "http://es01:9200/iller/_search"

	client := http.Client{
		Timeout: time.Second * 10,
	}

	req, err := http.NewRequest(http.MethodGet, esURL, nil)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	res, err := client.Do(req)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer res.Body.Close()

	var data map[string]interface{}
	err = json.NewDecoder(res.Body).Decode(&data)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	hits := data["hits"].(map[string]interface{})["hits"].([]interface{})
	randomIndex := rand.Intn(len(hits))
	randomCity := hits[randomIndex].(map[string]interface{})["_source"].(map[string]interface{})

	city := City{
		Il:      randomCity["il"].(string),
		Ilceler: randomCity["ilceler"].(string),
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(city)
}

func main() {
	http.HandleFunc("/", IndexHandler)
	http.HandleFunc("/staj", RandomCityHandler)

	fmt.Println("Server started on port 5555...")
	log.Fatal(http.ListenAndServe(":5555", nil))
}
