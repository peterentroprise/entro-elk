curl -X POST -u "elastic:$PASSWORD" -k "https://localhost:9200/_bulk?pretty" -H 'Content-Type: application/json' -d'
{"index": {"_index": "pokemons"}}
{"id": 1, "Name": "Pickachu", "type": "electric"}
{"index": {"_index": "pokemons"}}
{"id": 2, "Name": "Charmendar", "type": "fire"}
{"index": {"_index": "pokemons"}}
{"id": 3, "Name": "Golem", "type": "ground"}
{"index": {"_index": "pokemons"}}
{"id": 4, "Name": "Spoink", "type": "psychic"}
{"index": {"_index": "pokemons"}}
{"id": 5, "Name": "Togepi", "type": "egg"}
{"index": {"_index": "pokemons"}}
{"id": 6, "Name": "Bulbasaur", "type": "grass"}
'