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
        source = random_city.get('_source', {})
        il = source.get('il', 'Bilgi yok')
        nufus = source.get('nufus', 'Bilgi yok')
        ilceler = source.get('ilceler', '').split(', ') if source.get('ilceler') else ['Bilgi yok']
        

        return jsonify({"il": il, "nufus": nufus, "ilceler": ilceler})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4444)