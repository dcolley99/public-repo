import psycopg2
import os
import time
import random

counter = 0

while counter <= 10:
    counter += 1
    #  os.system("aws rds reboot-db-instance --db-instance-identifier pgsql-research")
    #  time.sleep(180)  # wait for 5 minutes, give the reboot a chance to take place

    #  TEST 1 - SELECT WITH PREDICATES

    db = psycopg2.connect (
        user="postgres_del",
        password="YPXMjhc9wJuyTWfBT793qXzw",
        host="pgsql-research.crmehlaeqqov.eu-west-2.rds.amazonaws.com",
        database="research")
    cur = db.cursor()
    sql = "SELECT pg_stat_statements_reset();"
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = "SELECT  to_timestamp(\"S\") FROM \
        (     SELECT SUM(\"DateTimeIncrement\") AS \"S\" \
        FROM \"deltaTestRandom100k\" \
        WHERE \"Category\" = 'E') AS src "
    print(sql)
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = ";WITH queryplandata AS ( \
    SELECT totalcost, planrows \
    FROM estimate_cost (  ' \
    SELECT  to_timestamp(\"S\") FROM \
        (     SELECT SUM(\"DateTimeIncrement\") AS \"S\" \
        FROM \"deltaTestRandom100k\" \
        WHERE \"Category\" = ''E'') AS src' ) ) \
    , \
    runstats AS ( \
    SELECT total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows \
    FROM pg_stat_statements WHERE \"query\" like ('%to_timestamp%') \
                              AND rows > 0 AND query not like ('%estimate_cost%') ) \
    , \
    cpustats AS ( \
    select relpages, reltuples from pg_class where relname = 'deltaTestRandom100k' ) \
    insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read, \
    blk_read_time, rowcount, relpages, reltuples, cpu_cost_per_tuple_relative) \
    select  'PgSQL Test 1 100k SELECT WITH PREDICATES', " + str(counter) + ", \
            runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read, \
            runstats.blk_read_time, runstats.rows, \
            cpustats.relpages, cpustats.reltuples, \
            (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative \
    from    runstats, cpustats, queryplandata "
    print(sql)
    cur.execute(sql)
    db.commit()
    cur.close()
    db.close()

    # TEST 2 - SELECT WITHOUT PREDICATES

    db = psycopg2.connect (
        user="postgres_del",
        password="YPXMjhc9wJuyTWfBT793qXzw",
        host="pgsql-research.crmehlaeqqov.eu-west-2.rds.amazonaws.com",
        database="research")
    cur = db.cursor()
    sql = "SELECT pg_stat_statements_reset();"
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = "SELECT  to_timestamp(\"S\") FROM \
        (     SELECT SUM(\"DateTimeIncrement\") AS \"S\" \
        FROM \"deltaTestRandom100k\" \
        ) AS src "
    print(sql)
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = ";WITH queryplandata AS ( \
    SELECT totalcost, planrows \
    FROM estimate_cost (  ' \
    SELECT  to_timestamp(\"S\") FROM \
        (     SELECT SUM(\"DateTimeIncrement\") AS \"S\" \
        FROM \"deltaTestRandom100k\" \
        ) AS src' ) ) \
    , \
    runstats AS ( \
    SELECT total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows \
    FROM pg_stat_statements WHERE \"query\" like ('%to_timestamp%') \
                              AND rows > 0 AND query not like ('%estimate_cost%') ) \
    , \
    cpustats AS ( \
    select relpages, reltuples from pg_class where relname = 'deltaTestRandom100k' ) \
    insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read, \
    blk_read_time, rowcount, relpages, reltuples, cpu_cost_per_tuple_relative) \
    select  'PgSQL Test 2 100k SELECT WITHOUT PREDICATES', " + str(counter) + ", \
            runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read, \
            runstats.blk_read_time, runstats.rows, \
            cpustats.relpages, cpustats.reltuples, \
            (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative \
    from    runstats, cpustats, queryplandata "
    print(sql)
    cur.execute(sql)
    db.commit()
    cur.close()
    db.close()

    # TEST 3 - INSERTION, 100K

    db = psycopg2.connect (
        user="postgres_del",
        password="YPXMjhc9wJuyTWfBT793qXzw",
        host="pgsql-research.crmehlaeqqov.eu-west-2.rds.amazonaws.com",
        database="research")
    cur = db.cursor()
    sql = "SELECT pg_stat_statements_reset();"
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = ";WITH nextval AS ( \
    SELECT	MAX(\"UQID\") AS \"M\" FROM \"deltaTestRandom100k\" \
    ), \
    latestValue AS ( \
    	SELECT	SUM(\"DateTimeIncrement\") AS \"S\" \
    	FROM	\"deltaTestRandom100k\" AS \"D\" \
    	WHERE	\"D\".\"Category\" = 'F' ) \
    INSERT INTO \"deltaTestRandom100k\" (\"UQID\", \"Category\" , \"DateTimeIncrement\") \
    SELECT	nextval.\"M\" + 1, 'F', latestValue.\"S\" + " + str(random.randint(1, 30)) + " \
    FROM	nextval, latestValue"
    print(sql)
    cur.execute(sql)
    cur.close()
    time.sleep(5)
    cur = db.cursor()
    sql = " \
    ;WITH queryplandata AS ( \
    SELECT totalcost, planrows \
    FROM estimate_cost (  ' \
    WITH nextval AS ( \
    SELECT	MAX(\"UQID\") AS \"M\" FROM \"deltaTestRandom100k\" \
    ), \
    latestValue AS ( \
    	SELECT	SUM(\"DateTimeIncrement\") AS \"S\" \
    	FROM	\"deltaTestRandom100k\" AS \"D\" \
    	WHERE	\"D\".\"Category\" = ''F'' ) \
    INSERT INTO \"deltaTestRandom100k\" (\"UQID\", \"Category\" , \"DateTimeIncrement\") \
    SELECT	nextval.\"M\" + 1, ''F'', latestValue.\"S\" + " + str(random.randint(1, 30)) + "  \
    FROM	nextval, latestValue ' \
     ) ) \
    , \
    runstats AS ( \
    SELECT query, total_exec_time, shared_blks_read, local_blks_read, blk_read_time, rows \
    FROM pg_stat_statements \
    WHERE \"query\" like ('WITH%nextval%') \
    AND rows > 0 AND query not like ('%estimate_cost%') ) \
    , \
    cpustats AS ( \
    select relpages, reltuples from pg_class where relname = 'deltaTestRandom100k' ) \
    insert into results (description, iteration, total_exec_time, shared_blks_read, local_blks_read,  \
    blk_read_time, rowcount, relpages, reltuples, cpu_cost_per_tuple_relative) \
    select  'PgSQL Test 3 100k INSERTION', " + str(counter) + ", \
           runstats.total_exec_time, runstats.shared_blks_read, runstats.local_blks_read, \
            runstats.blk_read_time, runstats.rows, \
            cpustats.relpages, cpustats.reltuples, \
            (queryplandata.totalcost / runstats.rows) - (cpustats.relpages * 1.0) AS cpu_cost_per_tuple_relative \
    from    runstats, cpustats, queryplandata"
    print(sql)
    cur.execute(sql)
    db.commit()
    cur.close()
    db.close()
