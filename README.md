# Setup
```
    docker compose up
```

Next commands create tables without sharding, with fdw sharding and native sharding respectively:

```
    create.sh psql-b
    create-fwd.sh
    create-native-sharding.sh
```

To perform benchmarking, execute

```
    ./benchmark psql-b  10000000
    ./benchmark psql-b1 10000000
    ./benchmark psql-b2 10000000
```

where "10000000" is the number of entries to insert

The rest of the scripts in the repo are self-explained and auxiliary



# Results
|                 |    WRITE   |   READ ALL   |   READ ID    |
|-----------------|------------|--------------|--------------|
| NO_SHARDING     |   21.297s  |    16.335s   |    0.525s    |
| FDW_SHARDING    | 1m56.608s  |    16.098s   |    0.428s    |
| NATIVE_SHARDING |   26.043s  |    16.335s   |    0.525s    |

### Some comments:

* I've performed these tests several times, so it's kinda average data.
* As it was mentioned above - the tests performed for 10 000 000 entries
* No indices
* "READ ALL" states for "select * from table" 
* "READ ID"  states for "select * from the table where id='666666'" 
* During implementation I made a mistake, and for FDW sharding created shards 1-5 instead of 0-4, and still got no error during inserts, because this data was written to the "master" table. This was not the case for native sharding - you must have an appropriate shard for a given value.

To sum up, obviously, no sharding performs better, but indices might've changed that. Anyway, if I'd be choosing the sharding technique, I'd definitely go with native sharding - it's substantially better performing, and to me as easy to configure as fdw sharding
