-- TEST 1: PGSQL, 100K, SELECT WITH PREDICATES
EXPLAIN VERBOSE
SELECT  MAX("DateTimeStamp")
FROM    "controlRandom10m"
WHERE   "Category" = 'E'

-- TEST 2: PGSQL, 100K, SELECT WITHOUT PREDICATES
EXPLAIN VERBOSE
SELECT  MAX("DateTimeStamp")
FROM    "controlRandom10m"
--WHERE   "Category" = 'E'

-- TEST 3: PGSQL, 100K, INSERTION, NO PREDICATES
EXPLAIN VERBOSE
WITH nextval AS (
    SELECT MAX("UQID") + 1 AS "MAXUQID" FROM "controlRandom10m" WHERE "Category" = 'F'
)
INSERT INTO "controlRandom10m" ("UQID","Category","DateTimeStamp")
SELECT "MAXUQID", 'F', NOW() + (RANDOM() * (INTERVAL '365 days'))
FROM "nextval"

-- TEST 4: PGSQL, 1M, SELECT WITH PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "controlRandom1m"
WHERE   "Category" = 'E'

-- TEST 5: PGSQL, 1M, SELECT WITHOUT PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "controlRandom1m"

-- TEST 6: PGSQL, 1M, INSERTION, NO PREDICATES
;WITH nextval AS (
    SELECT MAX("UQID") + 1 AS "MAXUQID" FROM "controlRandom100k" WHERE "Category" = 'F'
)
INSERT INTO "controlRandom1m" ("UQID","Category","DateTimeStamp")
SELECT "MAXUQID", 'F', NOW() + (RANDOM() * (INTERVAL '365 days'))
FROM "nextval"

-- TEST 7: PGSQL, 10M, SELECT WITH PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "controlRandom10m"
WHERE   "Category" = 'E'

-- TEST 8: PGSQL, 10M, SELECT WITHOUT PREDICATES
SELECT  MAX("DateTimeStamp")
FROM    "controlRandom10m"

-- TEST 9: PGSQL, 10M, INSERTION, NO PREDICATES
;WITH nextval AS (
    SELECT MAX("UQID") + 1 AS "MAXUQID" FROM "controlRandom100k" WHERE "Category" = 'F'
)
INSERT INTO "controlRandom10m" ("UQID","Category","DateTimeStamp")
SELECT "MAXUQID", 'F', NOW() + (RANDOM() * (INTERVAL '365 days'))
FROM "nextval"

SELECT * FROM results
WHERE description LIKE ('C %')

---

     ;WITH queryplandata AS (
	SELECT totalcost, planrows
	FROM estimate_cost (  '
		WITH nextval AS (
			SELECT MAX("UQID") + 1 AS "MAXUQID" FROM "controlRandom100k"
		)
		INSERT INTO "controlRandom100k" ("UQID","Category","DateTimeStamp")
			SELECT "MAXUQID", ''F'', NOW() + (RANDOM() * (INTERVAL ''365 days''))
			FROM "nextval"    '  ) )
,      runstats AS (
		SELECT total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows
		FROM pg_stat_statements WHERE "query" like ('%DateTimeStamp%')
		AND rows > 0 AND query not like ('%estimate_cost%') )
,     cpustats AS (     select relpages, reltuples from pg_class where relname = 'controlTestRandom100k' )

-- insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read,
-- blk_read_time, rowcount, relpages, reltuples, cpu_cost_per_tuple_relative)
	select  'C PgSQL Test 3 100k INSERTION', 1,
	runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read,
	runstats.blk_read_time, runstats.rows,
	cpustats.relpages, cpustats.reltuples,
	(queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative
	from    runstats, cpustats, queryplandata

select * from results where description like ('C %')

