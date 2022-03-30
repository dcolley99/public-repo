SELECT pg_stat_statements_reset();

-- TEST 1: PGSQL, 100K, SELECT WITH PREDICATES
EXPLAIN VERBOSE
SELECT  to_timestamp("S") FROM
    (     SELECT SUM("DateTimeIncrement") AS "S"
    FROM "deltaTestRandom10m"
   -- WHERE "Category" = 'E'
    ) AS src

-- GET QUERY COST, PLUG IN BELOW
-- TEST 1: PGSQL, 100K, SELECT WITH PREDICATES
;WITH queryplandata AS (
SELECT totalcost, planrows
FROM estimate_cost (  '
SELECT  to_timestamp("S") FROM
    (     SELECT SUM("DateTimeIncrement") AS "S"
    FROM "deltaTestRandom100k"
    WHERE "Category" = ''E'') AS src' ) )
,
runstats AS (
SELECT total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows
FROM pg_stat_statements WHERE "query" like ('%to_timestamp%')
                          AND rows > 0 AND query not like ('%estimate_cost%') )
,
cpustats AS (
select relpages, reltuples from pg_class where relname = 'deltaTestRandom100k' )

insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rowcount,
                     relpages, reltuples, cpu_cost_per_tuple_relative)
select  'PgSQL Test 1 100k SELECT WITH PREDICATES',
        3,
        runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read,
        runstats.blk_read_time, runstats.rows,
        cpustats.relpages, cpustats.reltuples,
        (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative
from    runstats, cpustats, queryplandata

-- TEST 3: PGSQL, 100K, INSERTION, NO PREDICATES
EXPLAIN VERBOSE
WITH nextval AS (
    SELECT	MAX("UQID") AS "M" FROM "deltaTestRandom10m"
),
latestValue AS (
	SELECT	SUM("DateTimeIncrement") AS "S"
	FROM	"deltaTestRandom10m" AS "D"
	WHERE	"D"."Category" = 'F' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category" , "DateTimeIncrement")
SELECT	nextval."M" + 1, 'F', latestValue."S" + (random() * 30.0) -- random time in 30s range
FROM	nextval, latestValue

;WITH queryplandata AS (
SELECT totalcost, planrows
FROM estimate_cost (  '
WITH nextval AS (
    SELECT	MAX("UQID") AS "M" FROM "deltaTestRandom100k"
),
latestValue AS (
	SELECT	SUM("DateTimeIncrement") AS "S"
	FROM	"deltaTestRandom100k" AS "D"
	WHERE	"D"."Category" = ''F'' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category" , "DateTimeIncrement")
SELECT	nextval."M" + 1, ''F'', latestValue."S" + (random() * 30.0)
FROM	nextval, latestValue '
 ) )
,
runstats AS (
SELECT query, total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows
FROM pg_stat_statements
WHERE "query" like ('WITH%nextval%')
AND rows > 0 AND query not like ('%estimate_cost%') )
,
cpustats AS (
select relpages, reltuples from pg_class where relname = 'deltaTestRandom100k' )

insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rowcount,
                     relpages, reltuples, cpu_cost_per_tuple_relative)
select  'PgSQL Test 3 100k INSERTION',
        3,
        runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read,
        runstats.blk_read_time, runstats.rows,
        cpustats.relpages, cpustats.reltuples,
        (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative
from    runstats, cpustats, queryplandata

-- truncate table results

select * from results

select * from "deltaTestRandom100k" order by "UQID" DESC limit 100
delete from "deltaTestRandom100k" where "UQID" > 100000


-- TEST 4: PGSQL, 1M, SELECT WITH PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "deltaTestRandom1m"
WHERE   "Category" = 'E'

-- TEST 5: PGSQL, 1M, SELECT WITHOUT PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "deltaTestRandom1m"

-- TEST 6: PGSQL, 1M, INSERTION, NO PREDICATES
;WITH nextval AS (
    SELECT MAX("UQID") + 1 AS "MAXUQID" FROM "deltaTestRandom100k"
)
...

-- TEST 7: PGSQL, 10M, SELECT WITH PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "deltaTestRandom10m"
WHERE   "Category" = 'E'

-- TEST 8: PGSQL, 10M, SELECT WITHOUT PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "deltaTestRandom10m"

-- TEST 9: PGSQL, 10M, INSERTION, NO PREDICATES
;WITH nextval AS (
    SELECT MAX("UQID") + 1 AS "MAXUQID" FROM "deltaTestRandom100k"
)
...