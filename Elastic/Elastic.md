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


## Snapshots
#### To take Snapshots
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

#### To restore indexes from snapshot
```bash
POST /_snapshot/<repository>/<snapshot>/_restore?wait_for_completion=false
{
  "indices": "<index>",
  "ignore_unavailable": true,
  "include_global_state": false,
  "include_aliases": false
}
```

## Tasks
#### To get all running tasks
```bash
GET _cat/tasks?v
GET _tasks
```
#### To Task task status 
```bash
GET _tasks/{task_id}
```
#### To cancel a task
```bash
POST /_tasks/{task_id}/_cancel
```


#Debugging

GET _cat/shards?v=true&h=index,shard,prirep,state,node,unassigned.reason&s=state
GET _cluster/allocation/explain 
{
“index”: “my-index-00001”,
“shard”: 0,
“primary”: true
}

Get index and cluster settings
GET my-index-00001/_settings?flat_settings=true&include_defaults=true
GET _cluster/settings?flat_settings=true&include_defaults=true
