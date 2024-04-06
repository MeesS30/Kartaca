from flask import Flask, jsonify
import requests
import random

app = Flask(__name__)

# Elasticsearch URL'si
es_url = "http://es01:9200/iller/_search"

@app.route("/")
def index():
    return "Merhaba Python!"

@app.route("/staj")
def random_city():
    try:
        # Elasticsearch'ten veri al
        response = requests.get(es_url)
        data = response.json()

        # İl listesini al
        hits = data['hits']['hits']

        # Rastgele bir il seç
        random_city = random.choice(hits)

        # Seçilen ilin adını ve ilçelerini al
        il = random_city['_source']['il']
        ilceler = random_city['_source']['ilceler']

        return jsonify({"il": il, "ilceler": ilceler})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4444)
