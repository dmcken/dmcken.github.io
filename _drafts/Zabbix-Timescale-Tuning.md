---
title: Zabbix TimescaleDB Tuning
# date: 2024-04-07 00:00:01 -0400
categories: [zabbix, postgresql]
tags: [zabbix, postgresql,timescaledb]
author: dmcken 
comments: false
---



## Problem definition

Your zabbix timescaledb instance is running slow? This post is for you. Quite a few of the settings should apply to postgresql but some may only apply to timescaledb (I'll note those cases).


### Zabbix DB



## Settings - Checking current value and setting:

```shell
# Connect to database
sudo -u postgres psql
```

#### Determine the config file:
```shell
postgres=# SHOW config_file;
               config_file
-----------------------------------------
 /etc/postgresql/14/main/postgresql.conf
(1 row)
```

#### View values
```sql
--- View status variable
SHOW ALL;
SHOW shared_buffers;

--- View current running server settings
SELECT * FROM pg_settings;
SELECT * FROM pg_settings WHERE name='shared_buffers' \x\g\x
--- The \x\g\x suffix displays the output in vertical and you don't put a terminating semi-colon
```

Last output looks like:
```shell
postgres=# SELECT * FROM pg_settings WHERE name='shared_buffers' \x\g\x
Expanded display is on.
-[ RECORD 1 ]---+-------------------------------------------------------------
name            | shared_buffers
setting         | 16384
unit            | 8kB
category        | Resource Usage / Memory
short_desc      | Sets the number of shared memory buffers used by the server.
extra_desc      |
context         | postmaster
vartype         | integer
source          | configuration file
min_val         | 16
max_val         | 1073741823
enumvals        |
boot_val        | 1024
reset_val       | 16384
sourcefile      | /etc/postgresql/14/main/postgresql.conf
sourceline      | 128
pending_restart | f

Expanded display is off.
postgres=#
```

## Settings to change

* Memory:
  * shared_buffers:
    * Zabbix benefits greatly from this as it controls how much memory Postgres uses for caching blocks for reads.
    * Recommended: 25% of RAM
    * TODO: show how to fetch the timescaledb chunk sizes.
* Logging
* WAL
* Profiling:
  
To fill out:
* work_mem:
* max_connections:
* cpu_tuple_cost
* effective_cache_size 
* Checkpoint settings:
  * decrease the checkpoint frequency\
  * checkpoint_segments
* Turn off syncronous commit
* max_wal_size
* wal_log_hints
* wal_compression
* wal_buffers
* commit_delay
* effective_io_concurrency
* Huge pages
* Logging:
  * logging_collector
  * log_statement
  * log_lock_waits
  * log_checkpoints
  * log_directory
  * log_temp_files
* timed_statistics
* Tools:
  * pg_stat_statements - shared_preload (external libraries)
  * pg_stat_activity
  * pgBadger
  * pgTune
  * pgAdmin

References:
1. [Postgresql wiki](https://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server)
2. [Revsys article](https://www.revsys.com/writings/postgresql-performance.html)
3. [Enterprise DB article](https://www.enterprisedb.com/postgres-tutorials/introduction-postgresql-performance-tuning-and-optimization)
4. [Sematext article](https://sematext.com/blog/postgresql-performance-tuning/)
5. [Vettabase article](https://vettabase.com/optimize-read-and-write-performance-in-postgresql/)
