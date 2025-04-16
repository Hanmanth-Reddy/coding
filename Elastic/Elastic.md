#### Remote Reindexing 
```bash
POST _reindex?wait_for_completion=false
{
#### "max_docs":2000,
  "source": {
    "remote": {
      "host": "http://<IP>:9200",
      "username": "elastic",
      "password": "<Password>"
    },
    "index": "<remote/source-Index>",
    "query": {
      "match_all": {}
    },
    "size": 5
  },
  "dest": {
    "index": "<Destination Index>"
  }
}
```

## Search Templates
#### To get Search Templates
```bash
GET _cluster/state/metadata?pretty&filter_path=metadata.stored_scripts.search_template1,metadata.stored_scripts.search_template2
```

## Index temaples
#### To get Index templates
```bash
GET _cat/templates
GET _template/template-1
```
#### To create/update Index tempaltes
```bash
PUT _template/template-1
{
		"index_patterns": [
			"app-search-*"
		],
		"settings": {
			"index": {}
		},
		"mappings": {  
			"properties": { }
		}
		"aliases": {}
	}
}
```

## Alias
#### To get alias
```bash
GET _cat/aliases
```
#### To create/add,Remote aliases
```bash
POST _aliases
{
  "actions": [
    {
      "add": {
        "index": "test1",
        "alias": "alias1"
      }
    },
	{
      "remove": {
        "index": "test2",
        "alias": "alias1"
      }
    }
  ]
}
```

#### To taking Snapshots
```bash
POST _snapshot/<repository>/<snapshot>?wait_for_completion=false
{
"indices": "<index>",
"ignore_unavailable": true,
"include_global_state": true,
"include_aliases": false,
"metadata": {
"taken_because": "prod backup"
}
}
```

#### To restore indexes fro snapshot
```bash
POST /_snapshot/<repository>/<snapshot>/_restore?wait_for_completion=false
{
  "indices": "<index>",
  "ignore_unavailable": true,
  "include_global_state": false,
  "include_aliases": false
}
```