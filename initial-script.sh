#!/bin/bash

# Define Elasticsearch host and port
ELASTICSEARCH_HOST="localhost"
ELASTICSEARCH_PORT="9200"

# İller dizinini oluştur
curl -X PUT "http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT/iller" -H 'Content-Type: application/json' -d '
{
    "mappings": {
        "properties": {
            "il": { "type": "text" },
            "ilceler": { "type": "text" }
        }
    }
}'

# Verileri toplu olarak ekle
curl -X POST "http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT/_bulk" -H 'Content-Type: application/json' -d '
{"index":{"_index":"iller"}}
{"il":"İstanbul", "ilceler":"Beşiktaş, Beyoğlu, Kadıköy, Şişli, Üsküdar, Fatih"}
{"index":{"_index":"iller"}}
{"il":"Ankara", "ilceler":"Çankaya, Keçiören, Yenimahalle, Mamak, Sincan, Altındağ"}
{"index":{"_index":"iller"}}
{"il":"İzmir", "ilceler":"Konak, Bornova, Karşıyaka, Buca, Bayraklı, Çiğli"}
{"index":{"_index":"iller"}}
{"il":"Bursa", "ilceler":"Osmangazi, Nilüfer, Yıldırım, Kestel, Gürsu, Mudanya"}
{"index":{"_index":"iller"}}
{"il":"Antalya", "ilceler":"Muratpaşa, Kepez, Konyaaltı, Aksu, Döşemealtı, Manavgat"}
{"index":{"_index":"iller"}}
{"il":"Adana", "ilceler":"Seyhan, Yüreğir, Sarıçam, Çukurova, Aladağ, Karaisalı"}
{"index":{"_index":"iller"}}
{"il":"Konya", "ilceler":"Selçuklu, Karatay, Meram, Ereğli, Karapınar, Akşehir"}
{"index":{"_index":"iller"}}
{"il":"Mersin", "ilceler":"Yenişehir, Mezitli, Toroslar, Akdeniz, Erdemli, Tarsus"}
{"index":{"_index":"iller"}}
{"il":"Diyarbakır", "ilceler":"Bağlar, Kayapınar, Yenişehir, Sur, Ergani, Çınar"}
{"index":{"_index":"iller"}}
{"il":"Samsun", "ilceler":"İlkadım, Atakum, Canik, Tekkeköy, Bafra, Alaçam"}
'

# Ülkeler dizinini oluştur
curl -X PUT "http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT/ulkeler" -H 'Content-Type: application/json' -d '
{
    "mappings": {
        "properties": {
            "ulke": { "type": "text" },
            "nufus": { "type": "integer" },
            "baskent": { "type": "text" }
        }
    }
}'

# Verileri toplu olarak ekle
curl -X POST "http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT/_bulk" -H 'Content-Type: application/json' -d '
{"index":{"_index":"ulkeler"}}
{"ulke":"Türkiye", "nufus":85000000, "baskent":"Ankara"}
{"index":{"_index":"ulkeler"}}
{"ulke":"Almanya", "nufus":83000000, "baskent":"Berlin"}
{"index":{"_index":"ulkeler"}}
{"ulke":"Fransa", "nufus":67000000, "baskent":"Paris"}
{"index":{"_index":"ulkeler"}}
{"ulke":"İngiltere", "nufus":68000000, "baskent":"Londra"}
{"index":{"_index":"ulkeler"}}
{"ulke":"İtalya", "nufus":60000000, "baskent":"Roma"}
{"index":{"_index":"ulkeler"}}
{"ulke":"İspanya", "nufus":47000000, "baskent":"Madrid"}
{"index":{"_index":"ulkeler"}}
{"ulke":"Yunanistan", "nufus":11000000, "baskent":"Atina"}
{"index":{"_index":"ulkeler"}}
{"ulke":"Portekiz", "nufus":10200000, "baskent":"Lizbon"}
{"index":{"_index":"ulkeler"}}
{"ulke":"Hollanda", "nufus":17500000, "baskent":"Amsterdam"}
{"index":{"_index":"ulkeler"}}
{"ulke":"Belçika", "nufus":11500000, "baskent":"Brüksel"}
'

