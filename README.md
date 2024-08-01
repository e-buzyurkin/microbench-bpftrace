# microbench-bpftrace

[pg_microbench](https://gitpglab.postgrespro.ru/pgpro-perf/pg_microbench)

## Scripts Description

#### query-analyzer.bt
 - Script from Frits Hoogland
 - [Source](https://databaseperformance.hashnode.dev/using-bpftrace-for-postgres-query-execution-tracing) 
 - Tracks all phases of executing simple queries
  
#### simple_query_trace.bt
 - My script
 - Tracks the beginning and end of the query
 - Prints the running time in ns of the query
 - JDBC sends 2 extra SET queries for some metadata, so queries that include SET are not being tracked

## Requirements:
  - bpftrace 0.17+
  - maven
  - jdk
  - postgres

## Postgres must be configured with --enable-dtrace flag
```
./configure --enable-dtrace
```

## JDBC and HikaryCP Settings
<pre>
HikariConfig config = new HikariConfig();
config.addDataSourceProperty("preferQueryMode", "simple");
-------------
PGSimpleDataSource pgds = new PGSimpleDataSource();
pgds.setPreferQueryMode(PreferQueryMode.SIMPLE);
</pre>

## bpftrace flags:  
<pre>
-f {text | json}        -- output type  
-o FILENAME             -- output to the file, if not set, outputs to stdout  
-c CMD                  -- execute command  
</pre>

## Finish after the process has finished
```
sudo bpftrace -o bpf.out ./simple_query_trace.bt -c "/bin/bash -c ./run_mvn.sh"
```
If you want to change maven command, change run_mvn.sh

## Finish by interruption
```
sudo bpftrace -o bpf.out ./simple_query_trace.bt
```