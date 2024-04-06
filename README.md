# commands:

```bash
docker-compose up -d
./initial-script.sh
```

# notes

- To login grafana form kartaca.localhost/grafana it is required to update following lines in grafana.ini file.


```ini
root_url = http://kartaca.localhost/grafana/
serve_from_sub_path = true
```